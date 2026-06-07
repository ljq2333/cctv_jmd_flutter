import 'package:dartz/dartz.dart';
import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/core/utils/date_utils.dart';
import 'package:cctv_jmd_flutter/data/models/search_result_model.dart';
import 'package:cctv_jmd_flutter/domain/repositories/epg_repository.dart';
import 'package:cctv_jmd_flutter/core/constants/channel_constants.dart';

class SearchProgramsUseCase {
  final EpgRepository _repository;

  SearchProgramsUseCase(this._repository);

  Future<Either<Failure, List<SearchResult>>> execute({
    required String query,
    String? channelId,
    DateTime? date,
  }) async {
    if (query.trim().isEmpty) {
      return const Right([]);
    }

    final targetDate = date ?? DateTime.now();
    final dateStr = AppDateUtils.formatToApiDate(targetDate);

    try {
      final channelIds = channelId != null
          ? [channelId]
          : ChannelConstants.channels.map((c) => c.id).toList();

      final results = <SearchResult>[];
      final queryLower = query.toLowerCase();

      for (final id in channelIds) {
        final epgResult = await _repository.getEpgData(
          channelId: id,
          date: dateStr,
        );

        epgResult.fold(
          (failure) => null,
          (epgData) {
            for (final program in epgData.programs) {
              if (program.title.toLowerCase().contains(queryLower)) {
                results.add(SearchResult(
                  channelId: id,
                  channelName: epgData.channelName,
                  program: program,
                ));
              }
            }
          },
        );
      }

      return Right(results);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
