import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/search/domain/usecase/get_movie_by_search_use_case.dart';
import 'package:movie_app/search/presentation/controller/search%20cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit(this.getMoviesBySearchUseCase) :super(SearchInitial());
GetMoviesBySearchUseCase getMoviesBySearchUseCase ;
  Future<void>getMoviesBySearch(String movieName,int pageNumber) async{
    emit(SearchLoading());
    final result = await getMoviesBySearchUseCase.call(movieName,pageNumber);
    result.fold((failure){
      emit(SearchFailure(failure.errMessage));

    }, (fullResponse){
      emit(SearchSuccess(fullResponse));
    });

  }

}