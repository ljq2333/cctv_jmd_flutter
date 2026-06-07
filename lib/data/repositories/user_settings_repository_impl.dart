import 'package:dartz/dartz.dart';
import 'package:cctv_jmd_flutter/core/errors/exceptions.dart';
import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/data/datasources/local_data_source.dart';
import 'package:cctv_jmd_flutter/data/models/user_settings_model.dart';
import 'package:cctv_jmd_flutter/domain/repositories/user_settings_repository.dart';

class UserSettingsRepositoryImpl implements UserSettingsRepository {
  final LocalDataSource _localDataSource;

  UserSettingsRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, UserSettings>> getSettings() async {
    try {
      final settings = await _localDataSource.getSettings();
      return Right(settings);
    } on StorageException catch (e) {
      return Left(StorageFailure(message: e.message));
    } catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveSettings(UserSettings settings) async {
    try {
      await _localDataSource.saveSettings(settings);
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(message: e.message));
    } catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }
  }
}
