import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/enums/request_state_enum.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_state.dart';
import 'package:movie_app/movies/presentation/widgets/movie_poster_item_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/utils/dummy.dart';
import '../controller/movies_bloc/movies_bloc.dart';
class TopRatedMoviesWidget extends StatelessWidget {
  const TopRatedMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MoviesBloc,MoviesState>(
        buildWhen: (previous,current)=> previous.topRatedState != current.topRatedState,
        builder: (context,state){
      if (state.topRatedState == RequestState.success){
        return FadeIn(
          duration: const Duration(milliseconds: 500),
          child: SizedBox(
            height: 170.0.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: moviesList.length,
              itemBuilder: (context, i) {
                return MoviePosterItemWidget(movie: state.topRatedMovies[i]);
              },
            ),
          ),
        );
      }
      else if(state.topRatedState ==RequestState.loading){
        return SizedBox(
          height: 170.0.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: 6,
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
      else if(state.topRatedState == RequestState.error){
        return Text(state.popularMessage,style: TextStyle(color: Colors.redAccent),);
      }
      return Text('asdf');
    }


    );
  }
}
