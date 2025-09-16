abstract class MovieDetailsEvents {
}
class GetMovieRecommendations extends MovieDetailsEvents{
  final int movieId;
  GetMovieRecommendations(this.movieId);
}
class GetMovieDetails extends MovieDetailsEvents{
  final int movieId;
  GetMovieDetails(this.movieId);
}