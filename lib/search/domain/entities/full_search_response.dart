import 'package:equatable/equatable.dart';

import '../../../movies/domain/entities/movie.dart';


class FullSearchResponse extends Equatable{
  final List<Movie> movies;
  final int numberOfPages ;
 const FullSearchResponse({required this.numberOfPages,required this.movies});

  @override
  List<Object?> get props => [movies ,numberOfPages];
}