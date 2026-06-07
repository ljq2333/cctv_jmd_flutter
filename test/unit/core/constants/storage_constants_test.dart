import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/core/constants/storage_constants.dart';

void main() {
  group('StorageConstants', () {
    test('favoritesBox should be defined', () {
      expect(StorageConstants.favoritesBox, isNotEmpty);
    });

    test('remindersBox should be defined', () {
      expect(StorageConstants.remindersBox, isNotEmpty);
    });

    test('cacheBox should be defined', () {
      expect(StorageConstants.cacheBox, isNotEmpty);
    });

    test('settingsBox should be defined', () {
      expect(StorageConstants.settingsBox, isNotEmpty);
    });

    test('favoritesKey should be defined', () {
      expect(StorageConstants.favoritesKey, isNotEmpty);
    });

    test('remindersKey should be defined', () {
      expect(StorageConstants.remindersKey, isNotEmpty);
    });

    test('settingsKey should be defined', () {
      expect(StorageConstants.settingsKey, isNotEmpty);
    });

    test('lastChannelKey should be defined', () {
      expect(StorageConstants.lastChannelKey, isNotEmpty);
    });

    test('cachePrefix should be defined', () {
      expect(StorageConstants.cachePrefix, isNotEmpty);
    });

    test('box names should be unique', () {
      final boxNames = [
        StorageConstants.favoritesBox,
        StorageConstants.remindersBox,
        StorageConstants.cacheBox,
        StorageConstants.settingsBox,
      ];

      expect(boxNames.toSet().length, boxNames.length);
    });
  });
}
