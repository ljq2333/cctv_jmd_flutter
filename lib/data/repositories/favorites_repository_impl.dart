import 'package:dartz/dartz.dart';
import 'package:cctv_jmd_flutter/core/errors/exceptions.dart';
import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/data/datasources/local_data_source.dart';
import 'package:cctv_jmd_flutter/data/models/favorite_model.dart';
import 'package:cctv_jmd_flutter/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final LocalDataSource _localDataSource;

  FavoritesRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<Favorite>>> getFavorites() async {
    try {
      final favorites = await _localDataSource.getFavorites();
      return Right(favorites);
    } on StorageException catch (e) {
      return Left(StorageFailure(message: e.message));
    } catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveFavorites(List<Favorite> favorites) async {
    try {
      await _localDataSource.saveFavorites(favorites);
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(message: e.message));
    } catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(Favorite favorite) async {
    try {
      final result = await getFavorites();
      return result.fold(
        (failure) => Left(failure),
        (favorites) async {
          final updated = [...favorites, favorite];
          return saveFavorites(updated);
        },
      );
    } catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String id) async {
    try {
      final result = await getFavorites();
      return result.fold(
        (failure) => Left(failure),
        (favorites) async {
          final updated = favorites.where((f) => f.id != id).toList();
          return saveFavorites(updated);
        },
      );
    } catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String id) async {
    try {
      final result = await getFavorites();
      return result.fold(
        (failure) => Left(failure),
        (favorites) => Right(favorites.any((f) => f.id == id)),
      );
    } catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }
  }
}
