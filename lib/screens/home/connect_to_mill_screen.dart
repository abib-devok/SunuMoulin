import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sunu_moulin_smarteco/l10n/app_localizations.dart';
import 'package:sunu_moulin_smarteco/providers/app_providers.dart';
import 'package:sunu_moulin_smarteco/widgets/app_drawer.dart';
import 'package:sunu_moulin_smarteco/widgets/shimmer_loading.dart';
import 'package:sunu_moulin_smarteco/widgets/modern_button.dart';
import 'package:sunu_moulin_smarteco/widgets/glass_card.dart';
import 'package:sunu_moulin_smarteco/services/ble_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class MillDevice {
  final String id;
  final String name;
  final String status; // 'Available', 'In Use', 'Offline'
  final String signalStrength; // 'strong', 'medium', 'weak', 'off'
  final bool isSimulated;

  MillDevice({
    required this.id,
    required this.name,
    required this.status,
    required this.signalStrength,
    this.isSimulated = false,
  });
}

class ConnectToMillScreen extends ConsumerStatefulWidget {
  const ConnectToMillScreen({super.key});

  @override
  ConsumerState<ConnectToMillScreen> createState() => _ConnectToMillScreenState();
}

class _ConnectToMillScreenState extends ConsumerState<ConnectToMillScreen> {
  List<MillDevice> _nearbyMills = [];
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _initializeDevices();
    _startScan();
  }

  void _initializeDevices() {
    _nearbyMills = [
      MillDevice(
        id: 'simulated_123',
        name: 'Sunu Moulin #123',
        status: 'Available',
        signalStrength: 'strong',
        isSimulated: true,
      ),
    ];
  }

  StreamSubscription? _scanSubscription;
  Timer? _throttleTimer;
  List<MillDevice> _lastResults = [];

  @override
  void dispose() {
    _scanSubscription?.cancel();
    _throttleTimer?.cancel();
    super.dispose();
  }

  Future<void> _startScan() async {
    if (_isScanning) return;
    
    setState(() => _isScanning = true);
    
    // On réinitialise la liste avec le device simulé
    setState(() {
      _nearbyMills = [
        MillDevice(
          id: 'simulated_123',
          name: 'Sunu Moulin #123',
          status: 'Available',
          signalStrength: 'strong',
          isSimulated: true,
        ),
      ];
    });

    try {
      final bleService = ref.read(bleServiceProvider);
      
      // Demande les permissions
      final hasPermission = await bleService.requestBluetoothPermissions();
      if (!hasPermission) {
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Permissions Bluetooth requises pour scanner')),
          );
          setState(() => _isScanning = false);
        }
        return;
      }

      // On s'abonne aux résultats du scan en temps réel avec throttling
      await _scanSubscription?.cancel();
      _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        if (!mounted) return;

        // On prépare les nouveaux devices dans une variable temporaire
        final List<MillDevice> updatedDevices = [
          MillDevice(
            id: 'simulated_123',
            name: 'Sunu Moulin #123',
            status: 'Available',
            signalStrength: 'strong',
            isSimulated: true,
          ),
        ];

        for (final r in results) {
          String signal = 'weak';
          if (r.rssi > -60) {
            signal = 'strong';
          } else if (r.rssi > -80) {
            signal = 'medium';
          }

          String name = "";
          
          // 1. Priorité aux champs standards
          if (r.advertisementData.advName.isNotEmpty) {
            name = r.advertisementData.advName;
          } else if (r.device.platformName.isNotEmpty) {
            name = r.device.platformName;
          } 

          // 2. Extraction intelligente depuis Manufacturer Data (cas pour certains PCs et Android)
          if (name.isEmpty) {
            for (var entry in r.advertisementData.manufacturerData.entries) {
              final data = entry.value;
              
              // Cas spécifique Microsoft (Company ID 6) : le nom est souvent à l'index 10+
              if (entry.key == 6 && data.length > 10) {
                try {
                  final possibleName = String.fromCharCodes(data.skip(10));
                  if (possibleName.trim().isNotEmpty && possibleName.runes.every((rk) => rk >= 32 && rk <= 126)) {
                    name = possibleName.trim();
                    break;
                  }
                } catch (_) {}
              }
              
              // Tentative générique
              if (name.isEmpty && data.length >= 4) {
                 try {
                  final possibleName = String.fromCharCodes(data);
                   final printableMatch = RegExp(r'[a-zA-Z0-9\-\s]{4,}').firstMatch(possibleName);
                   if (printableMatch != null) {
                     name = printableMatch.group(0)!.trim();
                     break;
                   }
                } catch (_) {}
              }
            }
          }

          // Fallback ultime
          if (name.isEmpty) {
            name = "Appareil Inconnu (${r.device.remoteId.toString().substring(0, 5)})";
          } else {
            debugPrint('📡 Appareil détecté : $name (${r.device.remoteId})');
          }

          updatedDevices.add(
            MillDevice(
              id: r.device.remoteId.toString(),
              name: name,
              status: 'Available',
              signalStrength: signal,
              isSimulated: false,
            ),
          );
        }

        // Throttling : On ne met à jour l'UI que toutes les 500ms max
        _lastResults = updatedDevices;
        if (_throttleTimer?.isActive ?? false) return;

        _throttleTimer = Timer(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _nearbyMills = _lastResults;
            });
          }
        });
      });

      // Lance le scan via le service
      await bleService.scanForDevices();
      
    } catch (e) {
      debugPrint('Erreur pendant le scan: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de scan: $e')),
        );
      }
    } finally {
      await _scanSubscription?.cancel();
      _throttleTimer?.cancel();
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(l10n.connectToMill),
            actions: [
              IconButton(
                icon: const Icon(Icons.help_outline_rounded),
                onPressed: () {},
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 10),
                _buildStatusGrid(context, l10n),
                const SizedBox(height: 32),
                FadeInLeft(
                  child: Text(
                    l10n.nearbyMills,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                if (_isScanning)
                  ...List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ShimmerLoading(width: double.infinity, height: 100, borderRadius: 20),
                  ))
                else
                  ..._nearbyMills.map((mill) => FadeInUp(
                    key: ValueKey(mill.id),
                    child: _MillDeviceCard(mill: mill),
                  )),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFAB(context, l10n),
    );
  }

  Widget _buildStatusGrid(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: FadeInLeft(
            child: _StatusInfoCard(
              title: l10n.bluetooth,
              status: l10n.enabled,
              icon: Icons.bluetooth_rounded,
              color: Colors.blue,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FadeInRight(
            child: _StatusInfoCard(
              title: l10n.wifi,
              status: l10n.enabled,
              icon: Icons.wifi_rounded,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFAB(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: ModernButton(
              label: l10n.scanForMills,
              icon: Icons.refresh_rounded,
              isLoading: _isScanning,
              onPressed: _startScan,
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton.large(
            heroTag: 'voice_fab',
            onPressed: () {},
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            child: const Icon(Icons.mic_none_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _StatusInfoCard extends StatelessWidget {
  final String title;
  final String status;
  final IconData icon;
  final Color color;

  const _StatusInfoCard({
    required this.title,
    required this.status,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(title, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5))),
          Text(status, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _MillDeviceCard extends StatelessWidget {
  final MillDevice mill;

  const _MillDeviceCard({required this.mill});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAvailable = mill.status == 'Available';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: isAvailable ? () => context.push('/milling-setup') : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.grain_rounded, color: theme.colorScheme.primary, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mill.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isAvailable ? Colors.green : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          mill.status,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: theme.colorScheme.onSurface.withOpacity(0.3)),
            ],
          ),
        ),
      ),
    );
  }
}
