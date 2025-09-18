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

class GetMovieCredits extends MovieDetailsEvents{
  final int movieId;
  GetMovieCredits(this.movieId);
}
class GetMoviePlayer extends MovieDetailsEvents{
  final int movieId;
  GetMoviePlayer(this.movieId);
}