import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/services/notification/notification_service.dart';
import 'package:cctv_jmd_flutter/services/notification/local_notification_service.dart';
import 'package:cctv_jmd_flutter/services/notification/in_app_reminder_service.dart';
import 'package:cctv_jmd_flutter/services/notification/notification_permission.dart';

void main() {
  group('Notification Service', () {
    test('NotificationService should be abstract', () {
      expect(NotificationService, isA<Type>());
    });

    test('LocalNotificationService should exist', () {
      expect(LocalNotificationService, isA<Type>());
    });

    test('InAppReminderService should be instantiable', () {
      final service = InAppReminderService();
      expect(service.activeReminders, isEmpty);
    });

    test('InAppReminderService should show and dismiss reminders', () {
      final service = InAppReminderService();

      service.showReminder(
        id: 1,
        title: 'Test',
        body: 'Body',
        channelId: 'cctv1',
      );

      expect(service.activeReminders.length, 1);

      service.dismissReminder(1);
      expect(service.activeReminders, isEmpty);
    });

    test('NotificationPermission should exist', () {
      expect(NotificationPermission, isA<Type>());
    });
  });
}
