class Constants{
  static const baseUrl= 'https://api.themoviedb.org/3/';
  static const apiKey= '4e9158510f775a61205b5ecafb44ac7f';
  static const getPopularPath= '${baseUrl}movie/popular?api_key=$apiKey';

  static const getNowPlayingPath= '${baseUrl}movie/now_playing?api_key=$apiKey';
  static const getTopRatedPath= '${baseUrl}movie/top_rated?api_key=$apiKey';
  static const baseImageUrl= 'https://image.tmdb.org/t/p/w500';
  static String imageUrl(String  imagePath)=>'$baseImageUrl$imagePath';
  static  String getMovieRecommendationsPath(int movieID)=> '${baseUrl}movie/${movieID.toString()}/recommendations?api_key=$apiKey' ;
  static  String getMovieDetailsPath(int movieID)=> '${baseUrl}movie/${movieID.toString()}?api_key=$apiKey' ;
  static  String getSpecificPagePopularPath(int pageNumber)=> '${baseUrl}movie/popular?api_key=$apiKey&page=$pageNumber' ;
  static  String getSpecificPageTopRatedPath(int pageNumber)=> '${baseUrl}movie/top_rated?api_key=$apiKey&page=$pageNumber' ;
  static  String getMovieCreditsPath(int movieID)=> '${baseUrl}movie/${movieID.toString()}/credits?api_key=$apiKey' ;
  static  String getMoviePlayer(int movieID)=> 'https://player.vidsrc.co/embed/movie/$movieID' ;
}
