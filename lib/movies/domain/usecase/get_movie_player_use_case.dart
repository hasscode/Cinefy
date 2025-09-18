import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/repositories/base_movies_repository.dart';

import '../../../core/error handling/failures.dart';
import '../entities/credit.dart';

class GetMoviePlayerUseCase{
  BaseMoviesRepository baseMoviesRepository;
  GetMoviePlayerUseCase(this.baseMoviesRepository);

  Future<Either<Failures, String>>call( int movieID)async{

    return await baseMoviesRepository.getMoviePlayer(movieID);
  }
}