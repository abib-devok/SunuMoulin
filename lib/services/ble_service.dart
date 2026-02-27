import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sunu_moulin_smarteco/models/app_models.dart';
import 'package:sunu_moulin_smarteco/services/storage_service.dart';

// Service simulant une connexion Bluetooth Low Energy (BLE) avec un moulin.
// Pour le prototype, ce service génère des données fictives.
class BleService extends ChangeNotifier {
  final StorageService _storageService;
  final _sensorDataController = StreamController<Map<String, double>>.broadcast();
  Timer? _simulationTimer;
  bool _isMilling = false;
  String? _connectedDeviceId;
  
  // État persistant de la mouture
  double _millingProgress = 0.0;
  DateTime? _millingStartTime;
  String? _currentGrain;

  BleService(this._storageService);

  // Flux de données de capteurs (Température, Vibration, Progression).
  Stream<Map<String, double>> get sensorDataStream => _sensorDataController.stream;

  // Indique si la simulation est en cours
  bool get isMilling => _isMilling;

  // Accesseurs pour l'état de mouture
  double get millingProgress => _millingProgress;
  String? get currentGrain => _currentGrain;
  DateTime? get millingStartTime => _millingStartTime;

  // ID de l'appareil connecté (null si aucun)
  String? get connectedDeviceId => _connectedDeviceId;

  // Demande les permissions Bluetooth nécessaires
  Future<bool> requestBluetoothPermissions() async {
    try {
      // Sur Android 12+ (SDK 31+), on a besoin de BLUETOOTH_SCAN et BLUETOOTH_CONNECT
      if (await Permission.bluetoothScan.isDenied) {
        final scanStatus = await Permission.bluetoothScan.request();
        if (!scanStatus.isGranted) {
          debugPrint('❌ Permission BLUETOOTH_SCAN refusée');
          return false;
        }
      }

      if (await Permission.bluetoothConnect.isDenied) {
        final connectStatus = await Permission.bluetoothConnect.request();
        if (!connectStatus.isGranted) {
          debugPrint('❌ Permission BLUETOOTH_CONNECT refusée');
          return false;
        }
      }

      // Sur les anciennes versions, vérifier la localisation (nécessaire pour BLE)
      if (await Permission.location.isDenied) {
        final locationStatus = await Permission.location.request();
        if (!locationStatus.isGranted) {
          debugPrint('❌ Permission LOCATION refusée (nécessaire pour BLE)');
          return false;
        }
      }

      debugPrint('✅ Toutes les permissions Bluetooth accordées');
      return true;
    } catch (e) {
      debugPrint('❌ Erreur lors de la demande de permissions: $e');
      return false;
    }
  }

  // Scanne les appareils BLE à proximité
  Future<void> scanForDevices({Duration timeout = const Duration(seconds: 4)}) async {
    try {
      // Vérifie si le Bluetooth est disponible
      if (!await FlutterBluePlus.isSupported) {
        debugPrint('❌ Bluetooth non supporté sur cet appareil');
        return;
      }

      // Démarre le scan avec des paramètres optimisés pour la découverte de noms
      debugPrint('🔍 Démarrage du scan BLE (mode continu)...');
      await FlutterBluePlus.startScan(
        timeout: timeout,
        androidScanMode: AndroidScanMode.lowLatency,
        continuousUpdates: true, // Important pour recevoir les noms mis à jour (Scan Response)
      );

      // On attend la fin du scan
      await Future.delayed(timeout);
      debugPrint('✅ Scan terminé');
    } catch (e) {
      debugPrint('❌ Erreur lors du scan BLE: $e');
    }
  }

  // Arrête le scan en cours
  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
      debugPrint('🛑 Scan BLE arrêté');
    } catch (e) {
      debugPrint('❌ Erreur lors de l\'arrêt du scan: $e');
    }
  }

  // Connecte à un appareil (pour l'instant juste simulation)
  void connectToDevice(String deviceId) {
    _connectedDeviceId = deviceId;
    debugPrint('📡 Connexion à l\'appareil: $deviceId');
    notifyListeners();
  }

  // Démarre la simulation (nouveau cycle)
  void startSensorSimulation({required String grain, required double quantity}) {
    if (_isMilling) return;

    _isMilling = true;
    _currentGrain = grain;
    _millingStartTime = DateTime.now();
    _millingProgress = 0.0;

    debugPrint('🔵 BleService: Nouveau cycle démarré ($grain, ${quantity}kg)');
    _startTimer();
  }

  // Reprend un cycle mis en pause
  void resumeSensorSimulation() {
    if (_isMilling || _millingProgress >= 1.0) return;
    
    _isMilling = true;
    debugPrint('🔵 BleService: Cycle repris à ${(_millingProgress * 100).toInt()}%');
    _startTimer();
  }

  // Met en pause (arrête le timer mais garde le progrès)
  void pauseSensorSimulation() {
    _simulationTimer?.cancel();
    _simulationTimer = null;
    _isMilling = false;
    debugPrint('🟡 BleService: Cycle mis en pause à ${(_millingProgress * 100).toInt()}%');
    notifyListeners();
  }

  void _startTimer() {
    _simulationTimer?.cancel();
    final random = Random();
    double temperature = 40.0; // Suppose déjà un peu chaud si on reprend
    double vibration = 0.3;

    _simulationTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      // Simulation simplifiée
      if (temperature < 65.0) temperature += random.nextDouble() * 0.5;
      vibration = 0.2 + random.nextDouble() * 0.1;

      _millingProgress += 0.01; 
      if (_millingProgress >= 1.0) {
        _millingProgress = 1.0;
        stopSensorSimulation(status: 'completed');
      }

      _sensorDataController.add({
        'temperature': temperature,
        'vibration': vibration,
        'progress': _millingProgress,
      });
      
      notifyListeners();
    });
    notifyListeners();
  }

  // Arrête définitivement la simulation et sauvegarde en historique.
  void stopSensorSimulation({String status = 'failed'}) {
    _simulationTimer?.cancel();
    _simulationTimer = null;
    
    // Sauvegarde de la session dans l'historique seulement si on a commencé
    if (_millingStartTime != null && _isMilling) {
      final session = Session(
        sessionId: "SESS-${DateTime.now().millisecondsSinceEpoch}",
        startTime: _millingStartTime!,
        durationSeconds: DateTime.now().difference(_millingStartTime!).inSeconds,
        status: status,
      );
      _storageService.saveSession(session);
      debugPrint('💾 Session sauvegardée : ${session.sessionId} ($status)');
    }

    _isMilling = false;
    _millingStartTime = null;
    _currentGrain = null;
    // On ne remet à zéro le progrès que si c'est fini ou arrêté par l'utilisateur
    if (status == 'completed' || status == 'failed') {
       _millingProgress = 1.0; // On laisse à 1.0 si fini pour l'affichage success
    }

    debugPrint('🔴 BleService: Cycle arrêté');
    Future.microtask(() => notifyListeners());
  }

  // Ferme le controller
  @override
  void dispose() {
    _sensorDataController.close();
    super.dispose();
  }
}
