import 'package:equatable/equatable.dart';
import 'package:movie_app/movies/domain/entities/movie.dart';
import 'package:movie_app/movies/domain/entities/movie_details.dart';

import '../../../../core/utils/enums/request_state_enum.dart';

class MoviesState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final RequestState nowPlayingState;
  final String nowPlayingMessage;

  final List<Movie> popularMovies;
  final RequestState popularState;
  final String popularMessage;

  final List<Movie> topRatedMovies;
  final RequestState topRatedState;
  final String topRatedMessage;


  final List<Movie> recommendedMovies;
  final RequestState recommendedMoviesState;
  final String recommendedMoviesMessage;


  const MoviesState({
this.recommendedMovies =const [],
    this.recommendedMoviesMessage ='',
    this.recommendedMoviesState =RequestState.loading,
    this.nowPlayingMovies = const [],
    this.nowPlayingState = RequestState.loading,
    this.nowPlayingMessage = '',
    this.popularMovies = const [],
    this.popularState = RequestState.loading,
    this.popularMessage = '',
    this.topRatedMovies = const [],
    this.topRatedState = RequestState.loading,
    this.topRatedMessage = '',
  });

  MoviesState copyWith({
    List<Movie>? recommendedMovies,
    String? recommendedMoviesMessage,
    RequestState? recommendedMoviesState,
    List<Movie>? nowPlayingMovies,
    RequestState? nowPlayingState,
    String? nowPlayingMessage,
    List<Movie>? popularMovies,
    RequestState? popularState,
    String? popularMessage,
    List<Movie>? topRatedMovies,
    RequestState? topRatedState,
    String? topRatedMessage,

  }) {
    return MoviesState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
      popularMovies: popularMovies ?? this.popularMovies,
      popularState: popularState ?? this.popularState,
      popularMessage: popularMessage ?? this.popularMessage,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedState: topRatedState ?? this.topRatedState,
      topRatedMessage: topRatedMessage ?? this.topRatedMessage,
      recommendedMovies: recommendedMovies ?? this.recommendedMovies,
      recommendedMoviesMessage: recommendedMoviesMessage ??this.recommendedMoviesMessage,
      recommendedMoviesState: recommendedMoviesState ??this.recommendedMoviesState

    );
  }

  @override
  List<Object?> get props => [
    nowPlayingMovies,
    nowPlayingState,
    nowPlayingMessage,
    popularMovies,
    popularState,
    popularMessage,
    topRatedMovies,
    topRatedState,
    topRatedMessage,
recommendedMoviesState,
    recommendedMovies,
    recommendedMoviesMessage
  ];
}
