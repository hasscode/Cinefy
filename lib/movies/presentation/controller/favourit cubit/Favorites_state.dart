import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<Movie> movies;
  final Set<int> favoriteIds;
  final String? errorMessage;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.movies = const [],
    this.favoriteIds = const {},
    this.errorMessage,
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<Movie>? movies,
    Set<int>? favoriteIds,
    String? errorMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, movies, favoriteIds, errorMessage];
}
