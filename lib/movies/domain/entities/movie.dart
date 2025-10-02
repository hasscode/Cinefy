import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final List<int> genreIds;
  final String title;
  final String? backdropPath;
  final String? posterPath;
  final String overview;
  final String releaseDate;
  final double voteAvg;

  const Movie({
    required this.posterPath,
    required this.id,
    required this.genreIds,
    required this.title,
    required this.backdropPath,
    required this.overview,
    required this.voteAvg,
    required this.releaseDate,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    genreIds,
    title,
    backdropPath,
    overview,
    releaseDate,
    voteAvg,
    posterPath
  ];
}
