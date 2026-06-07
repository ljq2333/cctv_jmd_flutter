import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/data/models/reminder_model.dart';

void main() {
  group('Reminder', () {
    test('should create from JSON', () {
      final json = {
        'id': 'rem_1',
        'channelId': 'cctv1',
        'title': '早间新闻',
        'startTime': 1780763470,
        'reminderTime': 1780763170,
        'enabled': true,
      };

      final reminder = Reminder.fromJson(json);

      expect(reminder.id, 'rem_1');
      expect(reminder.enabled, isTrue);
    });

    test('should support copyWith', () {
      const reminder = Reminder(
        id: 'rem_1',
        channelId: 'cctv1',
        title: 'News',
        startTime: 100,
        reminderTime: 90,
      );

      final copied = reminder.copyWith(enabled: false);

      expect(copied.enabled, isFalse);
      expect(copied.id, 'rem_1');
    });
  });
}
