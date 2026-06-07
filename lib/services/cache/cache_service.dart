abstract class CacheService {
  Future<T?> get<T>(String key);
  Future<void> put<T>(String key, T value, {Duration? expiration});
  Future<void> remove(String key);
  Future<void> clear();
  Future<int> getSize();
}
