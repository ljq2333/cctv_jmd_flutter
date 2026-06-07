import 'cache_service.dart';

class CacheCleanupStrategy {
  final CacheService _cacheService;
  final int _maxEntries;

  CacheCleanupStrategy(
    this._cacheService, {
    int maxEntries = 100,
  }) : _maxEntries = maxEntries;

  Future<void> cleanup() async {
    final size = await _cacheService.getSize();
    if (size > _maxEntries) {
      await _cacheService.clear();
    }
  }
}
