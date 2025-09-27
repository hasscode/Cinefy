import '../../../domain/entities/movie.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

// Add
class AddFavoritesLoading extends FavoritesState {}
class AddFavoritesSuccess extends FavoritesState {}
class AddFavoritesFailure extends FavoritesState {
  final String message;
  AddFavoritesFailure(this.message);
}

// Delete
class DeleteFavoritesLoading extends FavoritesState {}
class DeleteFavoritesSuccess extends FavoritesState {}
class DeleteFavoritesFailure extends FavoritesState {
  final String message;
  DeleteFavoritesFailure(this.message);
}

// Get
class GetFavoritesLoading extends FavoritesState {}
class GetFavoritesSuccess extends FavoritesState {
  final List<Movie> favorites; // أو List<MovieModel>
  GetFavoritesSuccess(this.favorites);
}
class GetFavoritesFailure extends FavoritesState {
  final String message;
  GetFavoritesFailure(this.message);
}

//check if exist
class MovieExist extends FavoritesState{}
class MovieNotExist extends FavoritesState{}
class CheckFailure extends FavoritesState{
  final String message;
  CheckFailure(this.message);
}