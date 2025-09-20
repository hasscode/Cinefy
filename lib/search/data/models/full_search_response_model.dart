import 'package:movie_app/search/domain/entities/full_search_response.dart';
import '../../../movies/data/models/movie_model.dart';


class FullSearchResponseModel extends FullSearchResponse {
  const FullSearchResponseModel({
    required super.numberOfPages,
    required super.movies,
  });

  factory FullSearchResponseModel.fromJson(Map<String, dynamic> json) {
    return FullSearchResponseModel(
      numberOfPages: json['total_pages'],
       movies: (json['results'] as List)
        .map((movie) => MovieModel.fromJson(movie))
        .toList(),
    );
  }
}
