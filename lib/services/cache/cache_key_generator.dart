class CacheKeyGenerator {
  CacheKeyGenerator._();

  static String epgKey(String channelId, String date) {
    return 'epg_${channelId}_$date';
  }

  static String favoritesKey() => 'favorites';

  static String settingsKey() => 'settings';

  static String remindersKey() => 'reminders';
}
