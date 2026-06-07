abstract class NotificationService {
  Future<void> initialize();
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  });
  Future<void> cancelNotification(int id);
  Future<void> cancelAllNotifications();
  Future<bool> requestPermission();
  Future<bool> hasPermission();
}
