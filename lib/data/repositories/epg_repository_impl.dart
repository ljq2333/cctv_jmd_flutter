import 'package:dartz/dartz.dart';
import 'package:cctv_jmd_flutter/core/errors/exceptions.dart';
import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/data/datasources/cache_data_source.dart';
import 'package:cctv_jmd_flutter/data/datasources/remote_data_source.dart';
import 'package:cctv_jmd_flutter/data/models/epg_data_model.dart';
import 'package:cctv_jmd_flutter/domain/repositories/epg_repository.dart';

class EpgRepositoryImpl implements EpgRepository {
  final RemoteDataSource _remoteDataSource;
  final CacheDataSource _cacheDataSource;

  EpgRepositoryImpl(
    this._remoteDataSource,
    this._cacheDataSource,
  );

  @override
  Future<Either<Failure, EpgData>> getEpgData({
    required String channelId,
    required String date,
  }) async {
    try {
      final cached = await _cacheDataSource.getCachedEpg(channelId, date);
      if (cached != null) {
        return Right(cached);
      }

      final epgData = await _remoteDataSource.getEpgInfo(
        channelId: channelId,
        date: date,
      );

      await _cacheDataSource.cacheEpg(channelId, date, epgData);

      return Right(epgData);
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EpgData>>> getEpgDataForMultipleChannels({
    required List<String> channelIds,
    required String date,
  }) async {
    try {
      final results = <EpgData>[];
      for (final channelId in channelIds) {
        final result = await getEpgData(channelId: channelId, date: date);
        result.fold(
          (failure) => null,
          (data) => results.add(data),
        );
      }
      return Right(results);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
