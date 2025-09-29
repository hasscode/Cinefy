

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/add_movie_to_favorites_use_case.dart';
import '../../../domain/usecase/get_favorite_movies_use_case.dart';
import '../../../domain/usecase/is_exist_in_favorites_use_case.dart';
import '../../../domain/usecase/remove_movie_from_favorites_use_case.dart';
import 'Favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final AddMovieToFavoritesUseCase addMovieToFavoritesUseCase;
  final RemoveMovieFromFavoritesUseCase removeMovieFromFavoritesUseCase;
  final IsExistInFavoritesUseCase inFavoritesUseCase;
  final GetFavoriteMoviesUseCase getFavoriteMoviesUseCase;

  FavoritesCubit(
      this.addMovieToFavoritesUseCase,
      this.removeMovieFromFavoritesUseCase,
      this.inFavoritesUseCase,
      this.getFavoriteMoviesUseCase,
      ) : super(const FavoritesState());


  Future<void> getFavoriteMovies() async {
    emit(state.copyWith(status: FavoritesStatus.loading));
    final result = await getFavoriteMoviesUseCase.call();
    result.fold(
          (failure) => emit(state.copyWith(
        status: FavoritesStatus.failure,
        errorMessage: failure.errMessage,
      )),
          (movies) => emit(state.copyWith(
        status: FavoritesStatus.success,
        movies: movies,
        favoriteIds: movies.map((m) => m.id).toSet(),
      )),
    );
  }

  Future<void> addMovieToFavorites(int movieID, String name, String poster) async {
    final result = await addMovieToFavoritesUseCase.addToFavourites(movieID, name, poster);
    result.fold(
          (failure) => emit(state.copyWith(
        status: FavoritesStatus.failure,
        errorMessage: failure.errMessage,
      )),
          (_) async => await getFavoriteMovies(), // نعمل refresh
    );
  }


  Future<void> removeFromFavourites(int movieID) async {
    final result = await removeMovieFromFavoritesUseCase.call(movieID);
    result.fold(
          (failure) => emit(state.copyWith(
        status: FavoritesStatus.failure,
        errorMessage: failure.errMessage,
      )),
          (_) async => await getFavoriteMovies(), // نعمل refresh
    );
  }


  bool isExist(int movieID) {
    return state.favoriteIds.contains(movieID);
  }
}
