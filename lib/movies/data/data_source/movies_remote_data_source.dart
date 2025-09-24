import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_app/core/error%20handling/failures.dart';
import 'package:movie_app/core/utils/constants.dart';
import 'package:movie_app/movies/data/models/credit_model.dart';
import 'package:movie_app/movies/data/models/movie_details_model.dart';
import 'package:movie_app/movies/data/models/movie_model.dart';

abstract class MovieBaseRemoteDataSource{

  Future<Either<Failures,List<MovieModel>>> getNowPlayingMovies();
  Future<Either<Failures,List<MovieModel>>> getPopularMovies(int pageNumber);
  Future<Either<Failures,List<MovieModel>>> getTopRatedMovies(int pageNumber);
  Future<Either<Failures,List<MovieModel>>>  getMovieRecommendations(int movieID);
  Future<Either<Failures,MovieDetailsModel>>  getMovieDetails(int movieID);
  Future<Either<Failures, List<CreditModel>>>  getMovieCredits(int movieID);
  Future<Either<Failures, String>>  getMoviePlayer(int movieID);
  Future<Either<Failures, Unit>>  addToFavourites(int movieID,String movieName,String moviePoster);

}
class MovieRemoteDataSource implements MovieBaseRemoteDataSource {
  Dio dio;

final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
  MovieRemoteDataSource(this.dio);

  @override
  Future<Either<Failures, List<MovieModel>>> getNowPlayingMovies() async {
    try {
      final response = await Dio().get(Constants.getNowPlayingPath);
      if (response.data['success'] == false) {
        return left(ServerFailure.fromSuccessBody(response.data));
      } else {
        return right((response.data['results'] as List)
            .map((e) => MovieModel.fromJson(e))
            .toList());
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<MovieModel>>> getPopularMovies(
      int pageNumber) async {
    try {
      final response = await dio.get(
          Constants.getSpecificPagePopularPath(pageNumber));
      if (response.data['success'] == false) {
        return left(ServerFailure.fromSuccessBody(response.data));
      } else {
        return right((response.data['results'] as List)
            .map((e) => MovieModel.fromJson(e))
            .toList());
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<MovieModel>>> getTopRatedMovies(
      int pageNumber) async {
    try {
      final response = await dio.get(
          Constants.getSpecificPageTopRatedPath(pageNumber));
      if (response.data['success'] == false) {
        return left(ServerFailure.fromSuccessBody(response.data));
      } else {
        return right((response.data['results'] as List)
            .map((e) => MovieModel.fromJson(e))
            .toList());
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<MovieModel>>> getMovieRecommendations(
      int movieID) async {
    try {
      final response = await dio.get(
          Constants.getMovieRecommendationsPath(movieID));
      if (response.data['success'] == false) {
        return left(ServerFailure.fromSuccessBody(response.data));
      } else {
        return right((response.data['results'] as List)
            .map((e) => MovieModel.fromJson(e))
            .toList());
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, MovieDetailsModel>> getMovieDetails(
      int movieID) async {
    try {
      final response = await dio.get(Constants.getMovieDetailsPath(movieID));
      if (response.data['success'] == false) {
        return left(ServerFailure.fromSuccessBody(response.data));
      }
      else {
        return right(MovieDetailsModel.fromJson(response.data));
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failures, List<CreditModel>>> getMovieCredits(int movieID) async {
    try {
      final response = await dio.get(Constants.getMovieCreditsPath(movieID));
      if (response.data['success'] == false) {
        return left(ServerFailure.fromSuccessBody(response.data));
      } else {
        return right((response.data['cast'] as List)
            .map((e) => CreditModel.fromJson(e))
            .toList());
      }
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> getMoviePlayer(int movieID) async{
try {
  return right( Constants.getMoviePlayer(movieID));
} on Exception catch (e) {
  return left(ServerFailure(e.toString()));
}
  }

  @override
  Future<Either<Failures, Unit>> addToFavourites(int movieID,String movieName,String moviePoster) async{
    try {
      final String userId =  FirebaseAuth.instance.currentUser!.uid;
      final result = await usersCollection.doc(userId).collection('favorites').add(
          {
            'movieID': movieID,
            'movieName': movieName,
            'moviePoster': moviePoster,

          });
      return right(unit);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}