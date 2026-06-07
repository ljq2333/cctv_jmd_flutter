import 'package:hive_flutter/hive_flutter.dart';
import 'package:cctv_jmd_flutter/core/constants/storage_constants.dart';

class HiveInitializer {
  HiveInitializer._();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    await Hive.openBox(StorageConstants.favoritesBox);
    await Hive.openBox(StorageConstants.remindersBox);
    await Hive.openBox(StorageConstants.cacheBox);
    await Hive.openBox(StorageConstants.settingsBox);

    _initialized = true;
  }

  static bool get isInitialized => _initialized;
}
