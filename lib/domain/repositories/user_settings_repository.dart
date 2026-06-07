import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/data/models/user_settings_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserSettingsRepository {
  Future<Either<Failure, UserSettings>> getSettings();
  Future<Either<Failure, void>> saveSettings(UserSettings settings);
}
