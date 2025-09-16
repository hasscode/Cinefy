import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/movies/presentation/widgets/movie_details_widget.dart';
import 'package:movie_app/movies/presentation/widgets/movie_poster_item_widget.dart';
import 'package:movie_app/movies/presentation/widgets/movie_recommendations_widget.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/dummy.dart';
import '../controller/movie_details_bloc/movie_details_bloc.dart';
import '../controller/movie_details_bloc/movie_details_events.dart';
import '../controller/movies_bloc/movies_bloc.dart';
import '../controller/movies_bloc/movies_events.dart';

class MovieDetailsScreen extends StatelessWidget {

  const MovieDetailsScreen({super.key,required this.movieID});
  final int movieID ;
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=> sL<MovieDetailsBloc>()..add(GetMovieRecommendations(movieID)) ..add(GetMovieDetails(movieID)),
      child: Scaffold(
        backgroundColor: Color(0xff1E1E29),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.starsBackgroundImageBlur),fit: BoxFit.cover)
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: MovieDetailsWidget()
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  sliver: SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'MORE LIKE THIS',
                        style: TextStyle(
                          fontSize: 13.5.sp,
                          fontFamily: GoogleFonts.inter.toString(),
                          fontWeight: FontWeight.w400,
                          color: Color(0xffB6B6BA),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: MovieRecommendationsWidget()
                ),

              ],

            ),
          ),
        ),
      ),
    );
  }
}
