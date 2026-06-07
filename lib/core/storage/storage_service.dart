abstract class StorageService {
  Future<void> saveFavorites(List<Map<String, dynamic>> favorites);
  Future<List<Map<String, dynamic>>> getFavorites();

  Future<void> saveReminders(List<Map<String, dynamic>> reminders);
  Future<List<Map<String, dynamic>>> getReminders();

  Future<void> saveUserSettings(Map<String, dynamic> settings);
  Future<Map<String, dynamic>> getUserSettings();

  Future<void> saveCache(String key, Map<String, dynamic> data);
  Future<Map<String, dynamic>?> getCache(String key);
  Future<void> clearCache();
  Future<int> getCacheSize();

  Future<void> saveLastChannel(String channelId);
  Future<String?> getLastChannel();
}
