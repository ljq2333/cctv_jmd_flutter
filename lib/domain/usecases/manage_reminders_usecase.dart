import 'package:dartz/dartz.dart';
import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/data/models/reminder_model.dart';
import 'package:cctv_jmd_flutter/domain/repositories/reminders_repository.dart';

class ManageRemindersUseCase {
  final RemindersRepository _repository;

  ManageRemindersUseCase(this._repository);

  Future<Either<Failure, List<Reminder>>> getReminders() {
    return _repository.getReminders();
  }

  Future<Either<Failure, void>> addReminder(Reminder reminder) {
    return _repository.addReminder(reminder);
  }

  Future<Either<Failure, void>> removeReminder(String id) {
    return _repository.removeReminder(id);
  }

  Future<Either<Failure, void>> updateReminder(Reminder reminder) {
    return _repository.updateReminder(reminder);
  }
}
