import 'notification_service.dart';

class LocalNotificationService implements NotificationService {
  bool _initialized = false;

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
  }

  @override
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    if (!_initialized) await initialize();
  }

  @override
  Future<void> cancelNotification(int id) async {
    if (!_initialized) return;
  }

  @override
  Future<void> cancelAllNotifications() async {
    if (!_initialized) return;
  }

  @override
  Future<bool> requestPermission() async {
    return true;
  }

  @override
  Future<bool> hasPermission() async {
    return true;
  }
}
