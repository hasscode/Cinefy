import 'package:dartz/dartz.dart';
import 'package:movie_app/search/data/data_source/search_remote_data_source.dart';

import '../../../core/error handling/failures.dart';
import '../entities/full_search_response.dart';

abstract class SearchRepository {
  Future<Either<Failures,FullSearchResponse>>getMoviesBySearch(String movieName,int pageNumber) ;


}