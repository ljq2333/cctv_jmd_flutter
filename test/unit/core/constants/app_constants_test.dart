import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/constants/app_constants.dart';

void main() {
  group('AppConstants', () {
    test('appName should be defined', () {
      expect(AppConstants.appName, isNotEmpty);
    });

    test('appVersion should follow semver', () {
      expect(AppConstants.appVersion, matches(r'^\d+\.\d+\.\d+'));
    });

    test('defaultTheme should be system', () {
      expect(AppConstants.defaultTheme, 'system');
    });

    test('defaultReminderMinutesBefore should be 5', () {
      expect(AppConstants.defaultReminderMinutesBefore, equals(5));
    });

    test('maxCacheDays should be 7', () {
      expect(AppConstants.maxCacheDays, equals(7));
    });

    test('homepageLoadTimeout should be under 2 seconds', () {
      expect(AppConstants.homepageLoadTimeout, lessThanOrEqualTo(2000));
    });

    test('channelSwitchTimeout should be under 500ms', () {
      expect(AppConstants.channelSwitchTimeout, lessThanOrEqualTo(500));
    });

    test('searchTimeout should be under 1 second', () {
      expect(AppConstants.searchTimeout, lessThanOrEqualTo(1000));
    });
  });
}
