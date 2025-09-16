import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/data/data_source/movies_remote_data_source.dart';
import 'package:movie_app/movies/domain/entities/credit.dart';
import 'package:movie_app/movies/domain/entities/movie.dart';
import 'package:movie_app/movies/domain/entities/movie_details.dart';
import 'package:movie_app/movies/domain/repositories/base_movies_repository.dart';

import '../../../core/error handling/failures.dart';

class MoviesRepository implements BaseMoviesRepository{
  MovieBaseRemoteDataSource movieBaseRemoteDataSource;

  MoviesRepository(this.movieBaseRemoteDataSource);

  @override
  Future<Either<Failures, List<Movie>>> getNowPlaying() async{
    final  result = await movieBaseRemoteDataSource.getNowPlayingMovies();
    return result;

  }

  @override
  Future<Either<Failures, List<Movie>>>  getPopular(int pageNumber) async{
    final  result = await movieBaseRemoteDataSource.getPopularMovies(pageNumber);
    return result;
  }

  @override
  Future<Either<Failures, List<Movie>>>  getTopRated(int pageNumber) async{
    final  result = await movieBaseRemoteDataSource.getTopRatedMovies(pageNumber);
    return result;
  }

  @override
  Future<Either<Failures, MovieDetails>> getMovieDetails(int movieID) async{
   final result = await movieBaseRemoteDataSource.getMovieDetails(movieID);
   return result ;
  }

  @override
  Future<Either<Failures, List<Movie>>> getMovieRecommendations(int movieID) async{
    final  result = await movieBaseRemoteDataSource.getMovieRecommendations(movieID);
    return result;
  }

  @override
  Future<Either<Failures, List<Credit>>> getMovieCredits(int movieID) async{
final result =await movieBaseRemoteDataSource.getMovieCredits(movieID);
return result;
  }


}