import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/utils/enums/request_state_enum.dart';
import 'package:movie_app/movies/domain/usecase/get_movie_details.dart';
import 'package:movie_app/movies/domain/usecase/get_movie_recommendation_usecase.dart';
import 'package:movie_app/movies/domain/usecase/get_play_now_usecase.dart';
import 'package:movie_app/movies/domain/usecase/get_popular_usecase.dart';
import 'package:movie_app/movies/domain/usecase/get_top_rated_usecase.dart';

import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_state.dart';

import 'movies_events.dart';

class MoviesBloc extends Bloc <MoviesEvent ,MoviesState>{
  final GetPlayNowUseCase getNowPlaying;
  final GetPopularUsecase getPopular;
  final GetTopRatedUseCase getTopRated;

  MoviesBloc(this.getNowPlaying, this.getPopular, this.getTopRated) :super (MoviesState()){
    on<GetNowPlayingMovies>(_getNowPlayingMovies);
    on<GetPopularMovies>(_getPopularMovies);
    on<GetTopRatedMovies>(_getTopRatedMovies);

  }

Future<void>_getNowPlayingMovies(GetNowPlayingMovies event ,Emitter<MoviesState> emit)async{

    final result = await getNowPlaying.execute();
    result.fold((failure){
      emit(state.copyWith(
        nowPlayingState: RequestState.error,
        nowPlayingMessage: failure.errMessage
      ));

    }, (movies){
emit(state.copyWith(
  nowPlayingState: RequestState.success,
  nowPlayingMovies: movies
));
    });

}
Future<void>_getPopularMovies(GetPopularMovies event ,Emitter<MoviesState> emit)async{

  final result = await getPopular.execute(event.pageNumber);
  result.fold((failure){
    emit(state.copyWith(
      popularState: RequestState.error,
          popularMessage: failure.errMessage
    ));

  }, (movies){
    emit(state.copyWith(
      popularState: RequestState.success,
          popularMovies:  movies
    ));
  });
}
Future<void>_getTopRatedMovies(GetTopRatedMovies event ,Emitter<MoviesState> emit)async{

  final result = await getTopRated.execute(event.pageNumber);
  result.fold((failure){
    emit(
      state.copyWith(
        topRatedMessage: failure.errMessage,
        topRatedState: RequestState.error
      )
    );

  }, (movies){
    emit(state.copyWith(
      topRatedState: RequestState.success,
      topRatedMovies: movies
    ));
  });

}



}