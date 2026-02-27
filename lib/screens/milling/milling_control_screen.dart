import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sunu_moulin_smarteco/l10n/app_localizations.dart';
import 'package:sunu_moulin_smarteco/widgets/modern_button.dart';
import 'package:sunu_moulin_smarteco/widgets/glass_card.dart';
import 'package:sunu_moulin_smarteco/providers/app_providers.dart';

class MillingControlScreen extends ConsumerStatefulWidget {
  const MillingControlScreen({super.key});

  @override
  ConsumerState<MillingControlScreen> createState() => _MillingControlScreenState();
}

class _MillingControlScreenState extends ConsumerState<MillingControlScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  StreamSubscription? _sensorSubscription;
  double _currentProgress = 0.0;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Écoute les données du capteur pour mettre à jour l'UI locale
    final bleService = ref.read(bleServiceProvider);
    _currentProgress = bleService.millingProgress;
    
    _sensorSubscription = bleService.sensorDataStream.listen((data) {
      if (mounted) {
        setState(() {
          _currentProgress = data['progress'] ?? 0.0;
        });
        if (_currentProgress >= 1.0 && !_finished) {
          _finished = true;
          _showSuccess();
        }
      }
    });
  }

  void _showSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => FadeIn(
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 64),
          content: const Text(
            "Mouture terminée avec succès !",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: [
            ModernButton(
              label: "Retour à l'accueil",
              onPressed: () => context.go('/home'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sensorSubscription?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isMilling = ref.watch(bleServiceProvider.select((s) => s.isMilling));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.millControlTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProgressIndicator(theme),
              const SizedBox(height: 48),
              FadeInUp(
                child: Text(
                  !isMilling && _currentProgress < 1.0 ? "En pause" : "Mouture en cours...",
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  "Temps restant estimé : ${((1.0 - _currentProgress) * 100).toInt()} sec",
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5)),
                ),
              ),
              const SizedBox(height: 60),
              _buildControls(theme, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(ThemeData theme) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 220,
            height: 220,
            child: CircularProgressIndicator(
              value: _currentProgress,
              strokeWidth: 15,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
              strokeCap: StrokeCap.round,
              valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            ),
          ),
          Column(
            children: [
              Text(
                "${(_currentProgress * 100).toInt()}%",
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                ),
              ),
              Text(
                "TERMINÉ",
                style: theme.textTheme.labelLarge?.copyWith(
                  letterSpacing: 2,
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControls(ThemeData theme, AppLocalizations l10n) {
    final bleService = ref.read(bleServiceProvider);
    final isMilling = ref.watch(bleServiceProvider.select((s) => s.isMilling));

    return Row(
      children: [
        Expanded(
          child: ModernButton(
            label: !isMilling ? "Reprendre" : "Pause",
            icon: !isMilling ? Icons.play_arrow_rounded : Icons.pause_rounded,
            isSecondary: true,
            onPressed: () {
              if (isMilling) {
                bleService.pauseSensorSimulation();
              } else {
                bleService.resumeSensorSimulation();
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ModernButton(
            label: l10n.stop,
            icon: Icons.stop_rounded,
            onPressed: () {
              bleService.stopSensorSimulation(status: 'failed');
              context.go('/home');
            },
          ),
        ),
      ],
    );
  }
}
