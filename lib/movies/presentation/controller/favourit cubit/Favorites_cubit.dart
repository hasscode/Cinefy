import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/domain/usecase/add_movie_to_favorites_use_case.dart';
import 'package:movie_app/movies/presentation/controller/favourit%20cubit/Favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState>{
  FavoritesCubit(this.addMovieToFavoritesUseCase):super(FavoritesInitial());
  AddMovieToFavoritesUseCase addMovieToFavoritesUseCase ;

  Future<void>addMovieToFavorites(int movieID,String movieName,String moviePoster)async{
    emit(AddFavoritesLoading());
 final result = await addMovieToFavoritesUseCase.addToFavourites(movieID, movieName, moviePoster);

 result.fold((failure)=>emit(AddFavoritesFailure(failure.errMessage)), (unit)=>emit(AddFavoritesSuccess()));
  }

}