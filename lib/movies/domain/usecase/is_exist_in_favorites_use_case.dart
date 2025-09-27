import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/entities/movie.dart';
import 'package:movie_app/movies/domain/repositories/base_movies_repository.dart';

import '../../../core/error handling/failures.dart';

class IsExistInFavoritesUseCase {
  IsExistInFavoritesUseCase(this.baseMoviesRepository);
  BaseMoviesRepository baseMoviesRepository;
  Future<bool>  call(int movieID) async {
    return  await baseMoviesRepository.isExistInFavorites(movieID);
  }
}
