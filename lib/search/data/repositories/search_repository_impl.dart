import 'package:dartz/dartz.dart';

import 'package:movie_app/core/error%20handling/failures.dart';
import 'package:movie_app/search/data/data_source/search_remote_data_source.dart';

import 'package:movie_app/search/domain/entities/full_search_response.dart';

import '../../domain/repositories/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository{

  SearchRemoteDataSource searchRemoteDataSource;
  SearchRepositoryImpl(this.searchRemoteDataSource);
  @override
  Future<Either<Failures, FullSearchResponse>> getMoviesBySearch(String movieName,int pageNumber) async{
   return await searchRemoteDataSource.getMoviesBySearch(movieName,pageNumber);
  }
}