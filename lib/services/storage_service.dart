import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunu_moulin_smarteco/models/app_models.dart';

// Service pour gérer le stockage de données local avec Hive.
class StorageService {
  static const String _userBoxName = 'user_box';
  static const String _deviceBoxName = 'device_box';
  static const String _sessionBoxName = 'session_box';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(DeviceAdapter());
    Hive.registerAdapter(SessionAdapter());

    await Hive.openBox<User>(_userBoxName);
    await Hive.openBox<Device>(_deviceBoxName);
    await Hive.openBox<Session>(_sessionBoxName);
  }

  // --- Méthodes pour l'utilisateur ---
  Future<void> saveUser(User user) async {
    final box = Hive.box<User>(_userBoxName);
    await box.put(user.id, user);
  }

  User? getUser(String id) {
    final box = Hive.box<User>(_userBoxName);
    return box.get(id);
  }

  // --- Méthodes pour les appareils ---
  Future<void> saveDevice(Device device) async {
    final box = Hive.box<Device>(_deviceBoxName);
    await box.put(device.deviceId, device);
  }

  Device? getDevice(String id) {
    final box = Hive.box<Device>(_deviceBoxName);
    return box.get(id);
  }

  List<Device> getAllDevices() {
    final box = Hive.box<Device>(_deviceBoxName);
    return box.values.toList();
  }

  // --- Méthodes pour les sessions ---
  Future<void> saveSession(Session session) async {
    final box = Hive.box<Session>(_sessionBoxName);
    await box.put(session.sessionId, session);
  }

  Session? getSession(String id) {
    final box = Hive.box<Session>(_sessionBoxName);
    return box.get(id);
  }

  List<Session> getAllSessions() {
    final box = Hive.box<Session>(_sessionBoxName);
    return box.values.toList();
  }

  // Méthode pour nettoyer toutes les données (utile pour les tests ou la déconnexion)
  Future<void> clearAllData() async {
    await Hive.box<User>(_userBoxName).clear();
    await Hive.box<Device>(_deviceBoxName).clear();
    await Hive.box<Session>(_sessionBoxName).clear();
  }
}
