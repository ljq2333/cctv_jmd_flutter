import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/data/models/user_settings_model.dart';

void main() {
  group('UserSettings', () {
    test('should create with defaults', () {
      const settings = UserSettings();

      expect(settings.themeMode, AppThemeMode.system);
      expect(settings.lastChannelId, 'cctv1');
      expect(settings.reminderEnabled, isTrue);
      expect(settings.reminderMinutesBefore, 5);
    });

    test('should create from JSON', () {
      final json = {
        'theme': 'dark',
        'lastChannel': 'cctv5',
        'reminderEnabled': false,
        'reminderMethods': ['notification'],
        'reminderMinutesBefore': 10,
      };

      final settings = UserSettings.fromJson(json);

      expect(settings.themeMode, AppThemeMode.dark);
      expect(settings.lastChannelId, 'cctv5');
      expect(settings.reminderEnabled, isFalse);
      expect(settings.reminderMinutesBefore, 10);
    });

    test('should support copyWith', () {
      const settings = UserSettings();

      final copied = settings.copyWith(
        themeMode: AppThemeMode.dark,
        lastChannelId: 'cctv5',
      );

      expect(copied.themeMode, AppThemeMode.dark);
      expect(copied.lastChannelId, 'cctv5');
      expect(copied.reminderEnabled, isTrue);
    });

    test('should convert to JSON', () {
      const settings = UserSettings(
        themeMode: AppThemeMode.light,
        lastChannelId: 'cctv2',
      );

      final json = settings.toJson();

      expect(json['theme'], 'light');
      expect(json['lastChannel'], 'cctv2');
    });
  });
}
