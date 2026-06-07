import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/data/models/cache_entry_model.dart';

void main() {
  group('CacheEntry', () {
    test('should create from JSON', () {
      final json = {
        'key': 'cctv1_20260607',
        'data': {'test': 'value'},
        'timestamp': 1780830000,
      };

      final entry = CacheEntry.fromJson(json);

      expect(entry.key, 'cctv1_20260607');
      expect(entry.data['test'], 'value');
    });

    test('isExpired should return false for recent cache', () {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final entry = CacheEntry(
        key: 'test',
        data: {},
        timestamp: now,
      );

      expect(entry.isExpired, isFalse);
    });

    test('isExpired should return true for old cache', () {
      final oldTimestamp =
          DateTime.now().millisecondsSinceEpoch ~/ 1000 - (8 * 24 * 60 * 60);
      final entry = CacheEntry(
        key: 'test',
        data: {},
        timestamp: oldTimestamp,
      );

      expect(entry.isExpired, isTrue);
    });
  });
}
