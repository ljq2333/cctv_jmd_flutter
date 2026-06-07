import 'package:dartz/dartz.dart';
import 'package:cctv_jmd_flutter/core/errors/failures.dart';
import 'package:cctv_jmd_flutter/data/models/favorite_model.dart';
import 'package:cctv_jmd_flutter/domain/repositories/favorites_repository.dart';

class ManageFavoritesUseCase {
  final FavoritesRepository _repository;

  ManageFavoritesUseCase(this._repository);

  Future<Either<Failure, List<Favorite>>> getFavorites() {
    return _repository.getFavorites();
  }

  Future<Either<Failure, void>> addFavorite(Favorite favorite) async {
    final isFav = await _repository.isFavorite(favorite.id);
    return isFav.fold(
      (failure) => Left(failure),
      (exists) async {
        if (exists) {
          return const Right(null);
        }
        return _repository.addFavorite(favorite);
      },
    );
  }

  Future<Either<Failure, void>> removeFavorite(String id) {
    return _repository.removeFavorite(id);
  }

  Future<Either<Failure, bool>> isFavorite(String id) {
    return _repository.isFavorite(id);
  }
}
