import 'package:dartz/dartz.dart';
import 'package:cctv_jmd_flutter/core/errors/exceptions.dart';
import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/data/datasources/local_data_source.dart';
import 'package:cctv_jmd_flutter/data/models/reminder_model.dart';
import 'package:cctv_jmd_flutter/domain/repositories/reminders_repository.dart';

class RemindersRepositoryImpl implements RemindersRepository {
  final LocalDataSource _localDataSource;

  RemindersRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<Reminder>>> getReminders() async {
    try {
      final reminders = await _localDataSource.getReminders();
      return Right(reminders);
    } on StorageException catch (e) {
      return Left(StorageFailure(message: e.message));
    } catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveReminders(List<Reminder> reminders) async {
    try {
      await _localDataSource.saveReminders(reminders);
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(message: e.message));
    } catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addReminder(Reminder reminder) async {
    try {
      final result = await getReminders();
      return result.fold(
        (failure) => Left(failure),
        (reminders) async {
          final updated = [...reminders, reminder];
          return saveReminders(updated);
        },
      );
    } catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeReminder(String id) async {
    try {
      final result = await getReminders();
      return result.fold(
        (failure) => Left(failure),
        (reminders) async {
          final updated = reminders.where((r) => r.id != id).toList();
          return saveReminders(updated);
        },
      );
    } catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateReminder(Reminder reminder) async {
    try {
      final result = await getReminders();
      return result.fold(
        (failure) => Left(failure),
        (reminders) async {
          final updated = reminders
              .map((r) => r.id == reminder.id ? reminder : r)
              .toList();
          return saveReminders(updated);
        },
      );
    } catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }
  }
}
