import 'package:cctv_jmd_flutter/core/storage/storage_service.dart';
import 'package:cctv_jmd_flutter/data/models/favorite_model.dart';
import 'package:cctv_jmd_flutter/data/models/reminder_model.dart';
import 'package:cctv_jmd_flutter/data/models/user_settings_model.dart';
import 'local_data_source.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final StorageService _storageService;

  LocalDataSourceImpl(this._storageService);

  @override
  Future<List<Favorite>> getFavorites() async {
    final data = await _storageService.getFavorites();
    return data.map((e) => Favorite.fromJson(e)).toList();
  }

  @override
  Future<void> saveFavorites(List<Favorite> favorites) async {
    await _storageService.saveFavorites(
      favorites.map((e) => e.toJson()).toList(),
    );
  }

  @override
  Future<List<Reminder>> getReminders() async {
    final data = await _storageService.getReminders();
    return data.map((e) => Reminder.fromJson(e)).toList();
  }

  @override
  Future<void> saveReminders(List<Reminder> reminders) async {
    await _storageService.saveReminders(
      reminders.map((e) => e.toJson()).toList(),
    );
  }

  @override
  Future<UserSettings> getSettings() async {
    final data = await _storageService.getUserSettings();
    return UserSettings.fromJson(data);
  }

  @override
  Future<void> saveSettings(UserSettings settings) async {
    await _storageService.saveUserSettings(settings.toJson());
  }

  @override
  Future<String?> getLastChannel() async {
    return _storageService.getLastChannel();
  }

  @override
  Future<void> saveLastChannel(String channelId) async {
    await _storageService.saveLastChannel(channelId);
  }
}
