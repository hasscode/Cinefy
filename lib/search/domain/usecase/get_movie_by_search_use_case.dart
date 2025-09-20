import 'package:dartz/dartz.dart';
import 'package:movie_app/search/domain/repositories/search_repository.dart';

import '../../../core/error handling/failures.dart';
import '../entities/full_search_response.dart';

class GetMoviesBySearchUseCase{
  GetMoviesBySearchUseCase(this.searchRepository);
  SearchRepository searchRepository;
  Future<Either<Failures,FullSearchResponse>>call(String movieName,int pageNumber) async {
    return await searchRepository.getMoviesBySearch(movieName,pageNumber);
  }

}