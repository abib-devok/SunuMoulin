import 'package:hive/hive.dart';

part 'app_models.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String role; // 'admin', 'operator', 'guest'

  User({required this.id, required this.username, required this.role});
}

@HiveType(typeId: 1)
class Device extends HiveObject {
  @HiveField(0)
  final String deviceId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String status;

  Device({required this.deviceId, required this.name, required this.status});
}

@HiveType(typeId: 2)
class Session extends HiveObject {
  @HiveField(0)
  final String sessionId;

  @HiveField(1)
  final DateTime startTime;

  @HiveField(2)
  final int durationSeconds;

  @HiveField(3)
  final String status; // 'completed', 'failed'

  Session({
    required this.sessionId,
    required this.startTime,
    required this.durationSeconds,
    required this.status,
  });
}
