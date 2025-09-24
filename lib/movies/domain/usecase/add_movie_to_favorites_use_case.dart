import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/entities/movie.dart';
import 'package:movie_app/movies/domain/repositories/base_movies_repository.dart';

import '../../../core/error handling/failures.dart';

class AddMovieToFavoritesUseCase {
  AddMovieToFavoritesUseCase(this.baseMoviesRepository);
  BaseMoviesRepository baseMoviesRepository;
  Future<Either<Failures, Unit>>  addToFavourites(int movieID,String movieName,String moviePoster) async {
    return  await baseMoviesRepository.addToFavourites(movieID, movieName, moviePoster);
  }
}
