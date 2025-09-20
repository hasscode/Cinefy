import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/core/utils/constants.dart';
import 'package:movie_app/search/data/models/full_search_response_model.dart';

import '../../../core/error handling/failures.dart';

abstract class SearchRemoteDataSource{
  Future<Either<Failures,FullSearchResponseModel>>getMoviesBySearch(String movieName,int pageNumber);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource{

  Dio dio;
  SearchRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, FullSearchResponseModel>> getMoviesBySearch(String movieName,int pageNumber) async{
    try {
      final response = await dio.get(Constants.getMovieBySearch(movieName,pageNumber));
         if(response.data['success']== false){
       return left(ServerFailure.fromSuccessBody(response.data));
         }
         else {
       return right(FullSearchResponseModel.fromJson(response.data));
         }
    } on Exception catch (e) {
    if(e is DioException){
     return left(ServerFailure.fromDioException(e)) ;
    }
    else {return left(ServerFailure(e.toString())); }
    }


  }
}