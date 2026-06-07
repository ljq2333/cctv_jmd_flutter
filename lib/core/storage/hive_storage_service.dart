import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:cctv_jmd_flutter/core/constants/storage_constants.dart';
import 'storage_service.dart';

class HiveStorageService implements StorageService {
  Box get _favoritesBox => Hive.box(StorageConstants.favoritesBox);
  Box get _remindersBox => Hive.box(StorageConstants.remindersBox);
  Box get _cacheBox => Hive.box(StorageConstants.cacheBox);
  Box get _settingsBox => Hive.box(StorageConstants.settingsBox);

  @override
  Future<void> saveFavorites(List<Map<String, dynamic>> favorites) async {
    await _favoritesBox.put(
      StorageConstants.favoritesKey,
      jsonEncode(favorites),
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getFavorites() async {
    final data = _favoritesBox.get(StorageConstants.favoritesKey);
    if (data == null) return [];

    final List<dynamic> decoded = jsonDecode(data);
    return decoded.cast<Map<String, dynamic>>();
  }

  @override
  Future<void> saveReminders(List<Map<String, dynamic>> reminders) async {
    await _remindersBox.put(
      StorageConstants.remindersKey,
      jsonEncode(reminders),
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getReminders() async {
    final data = _remindersBox.get(StorageConstants.remindersKey);
    if (data == null) return [];

    final List<dynamic> decoded = jsonDecode(data);
    return decoded.cast<Map<String, dynamic>>();
  }

  @override
  Future<void> saveUserSettings(Map<String, dynamic> settings) async {
    await _settingsBox.put(
      StorageConstants.settingsKey,
      jsonEncode(settings),
    );
  }

  @override
  Future<Map<String, dynamic>> getUserSettings() async {
    final data = _settingsBox.get(StorageConstants.settingsKey);
    if (data == null) return {};

    return jsonDecode(data);
  }

  @override
  Future<void> saveCache(String key, Map<String, dynamic> data) async {
    final cacheKey = '${StorageConstants.cachePrefix}$key';
    await _cacheBox.put(cacheKey, jsonEncode(data));
  }

  @override
  Future<Map<String, dynamic>?> getCache(String key) async {
    final cacheKey = '${StorageConstants.cachePrefix}$key';
    final data = _cacheBox.get(cacheKey);
    if (data == null) return null;

    return jsonDecode(data);
  }

  @override
  Future<void> clearCache() async {
    await _cacheBox.clear();
  }

  @override
  Future<int> getCacheSize() async {
    int totalSize = 0;
    for (final key in _cacheBox.keys) {
      final value = _cacheBox.get(key);
      if (value is String) {
        totalSize += value.length;
      }
    }
    return totalSize;
  }

  @override
  Future<void> saveLastChannel(String channelId) async {
    await _settingsBox.put(StorageConstants.lastChannelKey, channelId);
  }

  @override
  Future<String?> getLastChannel() async {
    return _settingsBox.get(StorageConstants.lastChannelKey);
  }
}
