import 'package:animate_do/animate_do.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movie_app/core/utils/enums/request_state_enum.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_state.dart';

import 'package:movie_app/movies/presentation/widgets/movie_slider_item_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/movies_bloc/movies_bloc.dart';

class NowPlayingMovies extends StatelessWidget {
  const NowPlayingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (previous, current) =>
          previous.nowPlayingState != current.nowPlayingState,
      builder: (context, state) {
        if (state.nowPlayingState == RequestState.success) {
          return FadeIn(
            duration: Duration(milliseconds: 500),
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 700),
                autoPlayCurve: Curves.easeInOut,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                height: 300.0.h,

                onPageChanged: (index, reason) {},
              ),
              items: state.nowPlayingMovies.map((item) {
                return MovieSliderItemWidget(movie: item,);
              }).toList(),
            ),
          );
        } else if (state.nowPlayingState == RequestState.error) {
          return Center(
            child: SizedBox(
              height: 300.h,
              child: Text(
                state.nowPlayingMessage,
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          );
        } else if (state.nowPlayingState == RequestState.loading) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 30),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[850]!,
              highlightColor: Colors.grey[800]!,
              child: Container(
                margin: const EdgeInsets.only(right: 8.0),
                height: 300.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0.sp),
                ),
              ),
            ),
          );
        }
        return Text('koko');
      },
    );
  }
}
