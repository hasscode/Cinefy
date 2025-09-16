import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums/request_state_enum.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_details.dart';

class MovieDetailsState extends Equatable {
  final MovieDetails movieDetails;
  final RequestState movieDetailsRequest;
  final String movieDetailsMessage;
  final List<Movie> movieRecommendations;
  final RequestState movieRecommendationsState;
  final String movieRecommendationsMessage;

  const MovieDetailsState({
    this.movieDetails = const MovieDetails(
      voteCount: 0,
      backdropPath: '',
      genres: [],
      id: 0,
      overview: 'overview',
      releaseDate: 'releaseDate',
      runtime: 0,
      title: 'title',
      voteAverage: 0,
    ),
    this.movieDetailsRequest = RequestState.loading,
    this.movieDetailsMessage = '',
    this.movieRecommendations = const [],
    this.movieRecommendationsState = RequestState.loading,
    this.movieRecommendationsMessage = '',
  });

  MovieDetailsState copyWith({

    List<Movie>? movieRecommendations,
    RequestState? movieRecommendationsState,
    String? movieRecommendationsMessage,
    MovieDetails? movieDetails,
    RequestState? movieDetailsRequest,
    String? movieDetailsMessage,
}){
    return MovieDetailsState(
      movieDetails: movieDetails??this.movieDetails,
      movieRecommendationsState: movieRecommendationsState ?? this.movieRecommendationsState,
      movieRecommendationsMessage:
      movieRecommendationsMessage ?? this.movieRecommendationsMessage,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,
      movieDetailsRequest: movieDetailsRequest ?? this.movieDetailsRequest,
    );

  }


  @override
  // TODO: implement props
  List<Object?> get props => [  movieRecommendationsMessage,
    movieRecommendations,
    movieRecommendationsState,
    movieDetailsRequest,
    movieDetails,
    movieDetailsMessage,];
}
