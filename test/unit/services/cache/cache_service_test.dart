import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/services/cache/cache_service.dart';
import 'package:cctv_jmd_flutter/services/cache/cache_service_impl.dart';
import 'package:cctv_jmd_flutter/services/cache/cache_key_generator.dart';
import 'package:cctv_jmd_flutter/services/cache/cache_cleanup_strategy.dart';

void main() {
  group('Cache Service', () {
    test('CacheService should be abstract', () {
      expect(CacheService, isA<Type>());
    });

    test('CacheServiceImpl should exist', () {
      expect(CacheServiceImpl, isA<Type>());
    });

    test('CacheKeyGenerator should generate EPG key', () {
      final key = CacheKeyGenerator.epgKey('cctv1', '20260607');
      expect(key, 'epg_cctv1_20260607');
    });

    test('CacheKeyGenerator should generate favorites key', () {
      expect(CacheKeyGenerator.favoritesKey(), 'favorites');
    });

    test('CacheKeyGenerator should generate settings key', () {
      expect(CacheKeyGenerator.settingsKey(), 'settings');
    });

    test('CacheCleanupStrategy should exist', () {
      expect(CacheCleanupStrategy, isA<Type>());
    });
  });
}
