import 'package:movie_app/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.posterPath,
    required super.id,
    required super.genreIds,
    required super.title,
    required super.backdropPath,
    required super.overview,
    required super.voteAvg,
    required super.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      genreIds:  (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList() ??
          [],
      title: json['title'],
      backdropPath: json['backdrop_path']??'',
      posterPath: json['poster_path']??'',
      overview: json['overview']??'',
      voteAvg: (json['vote_average']??0).toDouble()??0 ,
      releaseDate: json['release_date']??'',
    );
  }
}
