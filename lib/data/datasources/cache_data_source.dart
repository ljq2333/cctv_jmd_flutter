import 'package:cctv_jmd_flutter/data/models/epg_data_model.dart';

class CacheDataSource {
  final Map<String, EpgData> _cache = {};
  final Map<String, DateTime> _timestamps = {};
  final Duration _expiration;

  CacheDataSource({Duration? expiration})
      : _expiration = expiration ?? const Duration(days: 7);

  Future<EpgData?> getCachedEpg(String channelId, String date) async {
    final key = '${channelId}_$date';
    if (!_cache.containsKey(key)) return null;

    final timestamp = _timestamps[key];
    if (timestamp != null &&
        DateTime.now().difference(timestamp) > _expiration) {
      _cache.remove(key);
      _timestamps.remove(key);
      return null;
    }

    return _cache[key];
  }

  Future<void> cacheEpg(String channelId, String date, EpgData data) async {
    final key = '${channelId}_$date';
    _cache[key] = data;
    _timestamps[key] = DateTime.now();
  }

  Future<void> clearCache() async {
    _cache.clear();
    _timestamps.clear();
  }

  int get cacheSize => _cache.length;
}
