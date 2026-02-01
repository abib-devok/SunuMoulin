import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

// Service simulant une connexion Bluetooth Low Energy (BLE) avec un moulin.
// Pour le prototype, ce service génère des données fictives.
class BleService extends ChangeNotifier {
  final _sensorDataController = StreamController<Map<String, double>>.broadcast();
  Timer? _simulationTimer;
  bool _isMilling = false;
  String? _connectedDeviceId; // ID de l'appareil connecté

  // Flux de données de capteurs (Température, Vibration, Progression).
  Stream<Map<String, double>> get sensorDataStream => _sensorDataController.stream;

  // Indique si la simulation est en cours
  bool get isMilling => _isMilling;

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
  Future<List<ScanResult>> scanForDevices({Duration timeout = const Duration(seconds: 4)}) async {
    try {
      // Vérifie si le Bluetooth est disponible
      if (!await FlutterBluePlus.isSupported) {
        debugPrint('❌ Bluetooth non supporté sur cet appareil');
        return [];
      }

      // Démarre le scan
      debugPrint('🔍 Démarrage du scan BLE...');
      await FlutterBluePlus.startScan(timeout: timeout);

      // Attend la fin du scan
      await Future.delayed(timeout);

      // Récupère les résultats
      final results = FlutterBluePlus.lastScanResults;
      debugPrint('✅ Scan terminé: ${results.length} appareils trouvés');

      return results;
    } catch (e) {
      debugPrint('❌ Erreur lors du scan BLE: $e');
      return [];
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

  // Démarre la simulation des données envoyées par le moulin.
  void startSensorSimulation() {
    // Si une simulation tourne déjà, on ne fait rien.
    if (_isMilling) return;

    _isMilling = true;
    debugPrint('🔵 BleService: Simulation démarrée, isMilling = $_isMilling');
    // Notification différée pour éviter de modifier le provider pendant le build
    Future.microtask(() {
      notifyListeners();
      debugPrint('🔵 BleService: Listeners notifiés (start)');
    });

    double temperature = 25.0; // Température ambiante de départ
    double vibration = 0.0;
    double progress = 0.0;
    final random = Random();

    _simulationTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      // Simulation d'une montée en température progressive
      if (temperature < 65.0) {
        temperature += random.nextDouble() * 0.5;
      } else {
        // Variation autour de 65°C une fois chaud
        temperature += (random.nextDouble() - 0.5) * 1.0;
      }

      // Simulation de vibrations (valeurs entre 0.0 et 1.0)
      // 0.0 - 0.5 : Normal
      // 0.5 - 0.8 : Élevé
      // > 0.8 : Critique
      vibration = 0.2 + random.nextDouble() * 0.1;
      // Parfois un pic de vibration
      if (random.nextDouble() > 0.95) vibration += 0.4;

      // Progression linéaire
      progress += 0.01; // +1% toutes les 500ms -> environ 50s pour 100%
      if (progress > 1.0) {
        progress = 1.0;
        stopSensorSimulation(); // Arrêt auto fin de cycle
      }

      _sensorDataController.add({
        'temperature': temperature,
        'vibration': vibration,
        'progress': progress,
      });
    });
  }

  // Arrête la simulation.
  void stopSensorSimulation() {
    _simulationTimer?.cancel();
    _simulationTimer = null;
    _isMilling = false;
    debugPrint('🔴 BleService: Simulation arrêtée, isMilling = $_isMilling');
    Future.microtask(() {
      notifyListeners();
      debugPrint('🔴 BleService: Listeners notifiés (stop)');
    });
  }

  // Ferme le controller (à appeler lors de la destruction du service, rarement dans un singleton).
  @override
  void dispose() {
    _sensorDataController.close();
    super.dispose();
  }
}
