import 'package:dartz/dartz.dart';
import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/data/models/user_settings_model.dart';
import 'package:cctv_jmd_flutter/domain/repositories/user_settings_repository.dart';

class ManageSettingsUseCase {
  final UserSettingsRepository _repository;

  ManageSettingsUseCase(this._repository);

  Future<Either<Failure, UserSettings>> getSettings() {
    return _repository.getSettings();
  }

  Future<Either<Failure, void>> saveSettings(UserSettings settings) {
    return _repository.saveSettings(settings);
  }

  Future<Either<Failure, void>> updateThemeMode(AppThemeMode themeMode) async {
    final result = await _repository.getSettings();
    return result.fold(
      (failure) => Left(failure),
      (settings) => _repository.saveSettings(
        settings.copyWith(themeMode: themeMode),
      ),
    );
  }

  Future<Either<Failure, void>> updateLastChannel(String channelId) async {
    final result = await _repository.getSettings();
    return result.fold(
      (failure) => Left(failure),
      (settings) => _repository.saveSettings(
        settings.copyWith(lastChannelId: channelId),
      ),
    );
  }

  Future<Either<Failure, void>> updateReminderSettings({
    bool? enabled,
    List<ReminderMethod>? methods,
    int? minutesBefore,
  }) async {
    final result = await _repository.getSettings();
    return result.fold(
      (failure) => Left(failure),
      (settings) => _repository.saveSettings(
        settings.copyWith(
          reminderEnabled: enabled,
          reminderMethods: methods,
          reminderMinutesBefore: minutesBefore,
        ),
      ),
    );
  }
}
