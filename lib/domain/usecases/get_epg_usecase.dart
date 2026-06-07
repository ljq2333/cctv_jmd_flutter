import 'package:dartz/dartz.dart';
import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/core/utils/date_utils.dart';
import 'package:cctv_jmd_flutter/data/models/epg_data_model.dart';
import 'package:cctv_jmd_flutter/domain/repositories/epg_repository.dart';

class GetEpgUseCase {
  final EpgRepository _repository;

  GetEpgUseCase(this._repository);

  Future<Either<Failure, EpgData>> execute({
    required String channelId,
    DateTime? date,
  }) async {
    final targetDate = date ?? DateTime.now();
    final dateStr = AppDateUtils.formatToApiDate(targetDate);

    return _repository.getEpgData(
      channelId: channelId,
      date: dateStr,
    );
  }
}
