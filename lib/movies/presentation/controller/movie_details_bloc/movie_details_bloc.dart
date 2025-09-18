import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/domain/usecase/get_credits_use_case.dart';
import 'package:movie_app/movies/domain/usecase/get_movie_player_use_case.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc/movie_details_events.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc/movie_details_state.dart';

import '../../../../core/utils/enums/request_state_enum.dart';
import '../../../domain/usecase/get_movie_details.dart';
import '../../../domain/usecase/get_movie_recommendation_usecase.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvents,MovieDetailsState>{
  final GetMovieRecommendationUseCase getMovieRecommendation;
  final GetMovieDetailsUseCase getMovieDetails;
  final GetCreditsUseCase getCreditsUseCase;
  final GetMoviePlayerUseCase getMoviePlayerUseCase;
  MovieDetailsBloc(this.getMovieDetails,this.getMovieRecommendation,this.getCreditsUseCase,this.getMoviePlayerUseCase):super (MovieDetailsState()){
    on<GetMovieRecommendations>(_getMovieRecommendations);
    on<GetMovieDetails>(_getMovieDetails);
    on<GetMovieCredits>(_getMovieCredits);
    on<GetMoviePlayer>(_getMoviePlayer);
  }
  Future<void>_getMovieRecommendations(GetMovieRecommendations event ,Emitter<MovieDetailsState> emit)async{

    final result = await getMovieRecommendation.execute(event.movieId);
    result.fold((failure){
      emit(
          state.copyWith(
              movieRecommendationsMessage: failure.errMessage,
              movieRecommendationsState: RequestState.error
          )
      );

    }, (movies){
      emit(state.copyWith(
          movieRecommendationsState: RequestState.success,
          movieRecommendations: movies
      ));
    });

  }
  Future<void>_getMovieDetails(GetMovieDetails event, Emitter<MovieDetailsState> emit)async{
    final result =await getMovieDetails.execute(event.movieId);
    result.fold((failure)=>
        emit(state.copyWith(
            movieDetailsRequest: RequestState.error,
            movieDetailsMessage: failure.errMessage
        ))
        , (movieDetails)=>
            emit(  state.copyWith(
                movieDetailsRequest: RequestState.success,
                movieDetails: movieDetails
            ))
    );

  }

  Future<void>_getMovieCredits(GetMovieCredits event ,Emitter<MovieDetailsState> emit)async{

    final result = await getCreditsUseCase.call(event.movieId);
    result.fold((failure){
      emit(
          state.copyWith(
              movieCreditsMessage: failure.errMessage,
              movieCreditsState: RequestState.error
          )
      );

    }, (credits){
      emit(state.copyWith(
          movieCreditsState: RequestState.success,
          movieCredits: credits
      ));
    });

  }

  Future<void>_getMoviePlayer(GetMoviePlayer event ,Emitter<MovieDetailsState> emit)async{

    final result = await getMoviePlayerUseCase.call(event.movieId);
    result.fold((failure){
      emit(
          state.copyWith(
              moviePlayerMessage: failure.errMessage,
              moviePlayerState: RequestState.error
          )
      );

    }, (player){
      emit(state.copyWith(
          moviePlayerState: RequestState.success,
          moviePlayer: player
      ));
    });

  }

}