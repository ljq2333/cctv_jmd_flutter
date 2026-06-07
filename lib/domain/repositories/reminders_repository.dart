import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/data/models/reminder_model.dart';
import 'package:dartz/dartz.dart';

abstract class RemindersRepository {
  Future<Either<Failure, List<Reminder>>> getReminders();
  Future<Either<Failure, void>> saveReminders(List<Reminder> reminders);
  Future<Either<Failure, void>> addReminder(Reminder reminder);
  Future<Either<Failure, void>> removeReminder(String id);
  Future<Either<Failure, void>> updateReminder(Reminder reminder);
}
