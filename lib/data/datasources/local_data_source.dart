import 'package:cctv_jmd_flutter/data/models/favorite_model.dart';
import 'package:cctv_jmd_flutter/data/models/reminder_model.dart';
import 'package:cctv_jmd_flutter/data/models/user_settings_model.dart';

abstract class LocalDataSource {
  Future<List<Favorite>> getFavorites();
  Future<void> saveFavorites(List<Favorite> favorites);

  Future<List<Reminder>> getReminders();
  Future<void> saveReminders(List<Reminder> reminders);

  Future<UserSettings> getSettings();
  Future<void> saveSettings(UserSettings settings);

  Future<String?> getLastChannel();
  Future<void> saveLastChannel(String channelId);
}
