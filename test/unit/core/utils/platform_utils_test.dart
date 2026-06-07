import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/utils/platform_utils.dart';

void main() {
  group('PlatformUtils', () {
    test('isAndroid should return a boolean', () {
      expect(PlatformUtils.isAndroid, isA<bool>());
    });

    test('isIOS should return a boolean', () {
      expect(PlatformUtils.isIOS, isA<bool>());
    });

    test('isWindows should return a boolean', () {
      expect(PlatformUtils.isWindows, isA<bool>());
    });

    test('isWeb should return a boolean', () {
      expect(PlatformUtils.isWeb, isA<bool>());
    });

    test('currentPlatformName should not be empty', () {
      expect(PlatformUtils.currentPlatformName, isNotEmpty);
    });
  });
}
