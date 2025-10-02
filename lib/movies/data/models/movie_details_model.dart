import 'package:movie_app/movies/data/models/genres_model.dart';
import 'package:movie_app/movies/domain/entities/geners.dart';
import 'package:movie_app/movies/domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel({
    required super.backdropPath,
    required super.genres,
    required super.id,
    required super.overview,
    required super.releaseDate,
    required super.runtime,
    required super.title,
    required super.voteAverage, required super.voteCount,
    required super.posterPath,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      voteCount: json['vote_count'] as int,
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      genres: (json['genres'] as List).map((genre)=> GenresModel.fromJson(genre)).toList(),
      id: json['id'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      title: json['title'],
      voteAverage: (json['vote_average'] as num).toDouble(),
    );
  }
}
