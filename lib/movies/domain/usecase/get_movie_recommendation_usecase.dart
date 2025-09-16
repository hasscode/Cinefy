import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/repositories/base_movies_repository.dart';

import '../../../core/error handling/failures.dart';
import '../entities/movie.dart';

class GetMovieRecommendationUseCase{
  BaseMoviesRepository baseMoviesRepository;
  GetMovieRecommendationUseCase(this.baseMoviesRepository);

  Future<Either<Failures, List<Movie>>> execute(int movieID) async {
    return  await baseMoviesRepository.getMovieRecommendations(movieID);

  }

}