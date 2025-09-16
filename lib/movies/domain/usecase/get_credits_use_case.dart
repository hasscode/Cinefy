import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/repositories/base_movies_repository.dart';

import '../../../core/error handling/failures.dart';
import '../entities/credit.dart';

class GetCreditsUseCase{
  BaseMoviesRepository baseMoviesRepository;
  GetCreditsUseCase(this.baseMoviesRepository);

  Future<Either<Failures, List<Credit>>>call( int movieID)async{

    return await baseMoviesRepository.getMovieCredits(movieID);
  }
}