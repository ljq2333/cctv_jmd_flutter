import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/utils/format_utils.dart';

void main() {
  group('FormatUtils', () {
    group('formatDuration', () {
      test('should format seconds to minutes', () {
        expect(FormatUtils.formatDuration(120), '2分钟');
      });

      test('should format seconds to hours and minutes', () {
        expect(FormatUtils.formatDuration(3660), '1小时1分钟');
      });

      test('should handle zero', () {
        expect(FormatUtils.formatDuration(0), '0分钟');
      });
    });

    group('formatCacheSize', () {
      test('should format bytes', () {
        expect(FormatUtils.formatCacheSize(500), '500 B');
      });

      test('should format kilobytes', () {
        expect(FormatUtils.formatCacheSize(1024), '1.0 KB');
      });

      test('should format megabytes', () {
        expect(FormatUtils.formatCacheSize(1048576), '1.0 MB');
      });
    });

    group('formatNumber', () {
      test('should add thousand separators', () {
        expect(FormatUtils.formatNumber(1234567), '1,234,567');
      });

      test('should handle small numbers', () {
        expect(FormatUtils.formatNumber(999), '999');
      });
    });
  });
}
