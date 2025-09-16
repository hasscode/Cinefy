import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/entities/movie_details.dart';
import '../../../core/error handling/failures.dart';
import '../repositories/base_movies_repository.dart';

class GetMovieDetailsUseCase {
GetMovieDetailsUseCase(this.baseMoviesRepository);
  BaseMoviesRepository baseMoviesRepository;
  Future<Either<Failures, MovieDetails>> execute(int movieID) async {

return  await baseMoviesRepository.getMovieDetails(movieID);
  }
}
