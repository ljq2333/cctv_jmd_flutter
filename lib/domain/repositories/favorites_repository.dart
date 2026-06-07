import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/data/models/favorite_model.dart';
import 'package:dartz/dartz.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<Favorite>>> getFavorites();
  Future<Either<Failure, void>> saveFavorites(List<Favorite> favorites);
  Future<Either<Failure, void>> addFavorite(Favorite favorite);
  Future<Either<Failure, void>> removeFavorite(String id);
  Future<Either<Failure, bool>> isFavorite(String id);
}
