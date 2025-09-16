import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/enums/request_state_enum.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc/movie_details_bloc.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc/movie_details_state.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/entities/movie.dart';
import '../controller/movies_bloc/movies_bloc.dart';
import 'movie_poster_item_widget.dart';
class MovieRecommendationsWidget extends StatelessWidget {
  const MovieRecommendationsWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      buildWhen: (previous,current)=> previous.movieRecommendationsState !=current.movieRecommendationsState,
        builder: (context, state) {
        print(state.movieRecommendations);
          if (state.movieRecommendationsState == RequestState.loading) {
            return  SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        height: 170.0.h,
                        width: 120.0.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0.sp),
                        ),
                      ),
                    )
                ),
                childCount: 4,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: .6,
                  crossAxisSpacing: 2

              ),
            );

          }
          else if (state.movieRecommendationsState ==RequestState.error){
return             SliverToBoxAdapter(child: Text(state.movieRecommendationsMessage),);
          }
          else if (state.movieRecommendationsState ==RequestState.success){
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: MoviePosterItemWidget(movie: state.movieRecommendations[i]),
                ),
                childCount: state.movieRecommendations.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: .6,
                  crossAxisSpacing: 2

              ),

    );
  }
         return Text('recommendation') ;
        }
    );
  }
}

