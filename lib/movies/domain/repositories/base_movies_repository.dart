import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/entities/credit.dart';
import 'package:movie_app/movies/domain/entities/movie.dart';
import 'package:movie_app/movies/domain/entities/movie_details.dart';

import '../../../core/error handling/failures.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failures, List<Movie>>> getNowPlaying();
  Future<Either<Failures, List<Movie>>> getPopular(int pageNumber);
  Future<Either<Failures, List<Movie>>> getTopRated(int pageNumber);
  Future<Either<Failures, MovieDetails>> getMovieDetails(int movieID);
  Future<Either<Failures, List<Movie>>> getMovieRecommendations(int movieID);
  Future<Either<Failures, List<Credit>>> getMovieCredits(int movieID);
  Future<Either<Failures, String>> getMoviePlayer(int movieID);
  Future<Either<Failures, Unit>>  addToFavourites(int movieID,String movieName,String moviePoster);
  Future<Either<Failures, Unit>>  removeFromFavourites(int movieID);
  Future< bool>  isExistInFavorites(int movieID);
  Future<Either<Failures, List<Movie>>>getFavoriteMovies();
}