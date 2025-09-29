abstract class MoviesEvent{}
 class GetNowPlayingMovies extends MoviesEvent{}
 class GetPopularMovies extends MoviesEvent{
  int pageNumber;
  GetPopularMovies(this.pageNumber);
 }
 class GetTopRatedMovies extends MoviesEvent{
  GetTopRatedMovies(this.pageNumber);
  int pageNumber;
 }
class GetRecommendationsForYou extends MoviesEvent{

}