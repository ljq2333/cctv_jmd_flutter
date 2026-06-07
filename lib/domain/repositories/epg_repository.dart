import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/data/models/epg_data_model.dart';
import 'package:dartz/dartz.dart';

abstract class EpgRepository {
  Future<Either<Failure, EpgData>> getEpgData({
    required String channelId,
    required String date,
  });

  Future<Either<Failure, List<EpgData>>> getEpgDataForMultipleChannels({
    required List<String> channelIds,
    required String date,
  });
}
