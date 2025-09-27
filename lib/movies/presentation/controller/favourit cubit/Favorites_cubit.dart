import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/domain/usecase/add_movie_to_favorites_use_case.dart';
import 'package:movie_app/movies/domain/usecase/get_favorite_movies_use_case.dart';
import 'package:movie_app/movies/domain/usecase/is_exist_in_favorites_use_case.dart';
import 'package:movie_app/movies/domain/usecase/remove_movie_from_favorites_use_case.dart';
import 'package:movie_app/movies/presentation/controller/favourit%20cubit/Favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(
    this.addMovieToFavoritesUseCase,
    this.removeMovieFromFavoritesUseCase,
    this.inFavoritesUseCase,
      this.getFavoriteMoviesUseCase
  ) : super(FavoritesInitial());
  AddMovieToFavoritesUseCase addMovieToFavoritesUseCase;
  RemoveMovieFromFavoritesUseCase removeMovieFromFavoritesUseCase;
  IsExistInFavoritesUseCase inFavoritesUseCase;
  GetFavoriteMoviesUseCase getFavoriteMoviesUseCase;

  Future<void> addMovieToFavorites(
    int movieID,
    String movieName,
    String moviePoster,
  ) async {
    emit(AddFavoritesLoading());
    final result = await addMovieToFavoritesUseCase.addToFavourites(
      movieID,
      movieName,
      moviePoster,
    );

    result.fold((failure) => emit(AddFavoritesFailure(failure.errMessage)), (
      unit,
    ) {
      emit(AddFavoritesSuccess());

    });
    await isExistInFavorites(movieID);
  }

  Future<void> removeFromFavourites(int movieID) async {
    emit(DeleteFavoritesLoading());
    final result = await removeMovieFromFavoritesUseCase.call(movieID);

    result.fold((failure) => emit(DeleteFavoritesFailure(failure.errMessage)), (
      unit,
    ) async{
      emit(DeleteFavoritesSuccess());

    });
    await isExistInFavorites(movieID);
  }

  Future<void> isExistInFavorites(int movieID) async {
    final result = await inFavoritesUseCase.call(movieID);
    if (result) {
      emit(MovieExist());
    } else {
      emit(MovieNotExist());
    }
  }

  Future<void> getFavoriteMovies() async {
    final result = await getFavoriteMoviesUseCase.call();
   result.fold((failure)=>emit(GetFavoritesFailure(failure.errMessage)), (movies)=>emit(GetFavoritesSuccess(movies)));
  }
  
}
