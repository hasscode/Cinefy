import 'package:movie_app/search/domain/entities/full_search_response.dart';

abstract class SearchState{}
class SearchInitial extends SearchState{}
class SearchLoading extends SearchState{}
class SearchSuccess extends SearchState{
  FullSearchResponse fullSearchResponse;
  SearchSuccess(this.fullSearchResponse);

}
class SearchFailure extends SearchState{
  String errMessage;
  SearchFailure(this.errMessage);
}