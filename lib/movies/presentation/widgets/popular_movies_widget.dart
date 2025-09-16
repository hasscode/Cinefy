import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_state.dart';
import 'package:movie_app/movies/presentation/widgets/movie_poster_item_widget.dart';
import 'package:movie_app/movies/presentation/widgets/movies_category_header_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/dummy.dart';
import '../../../core/utils/enums/request_state_enum.dart';
import '../controller/movies_bloc/movies_bloc.dart';
class PopularMoviesWidget extends StatelessWidget {
  const PopularMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<MoviesBloc,MoviesState>(
        buildWhen: (previous,current)=> previous.popularState !=current.popularState,
      builder: (context,state){
        if(state.popularState ==RequestState.success){
          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              height: 170.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: state.popularMovies.length,
                itemBuilder: (context, index) {
                  return MoviePosterItemWidget(movie: state.popularMovies[index]);
                },
              ),
            ),
          );

        }
        else if(state.popularState ==RequestState.error){
          return Text(state.popularMessage,style: TextStyle(color: Colors.redAccent),);
        }
        else if (state.popularState == RequestState.loading) {
          return SizedBox(
            height: 170.0.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
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
                );
              },
            ),
          );
        }
        return Text('hyhyo');

      }
    );
  }
}
