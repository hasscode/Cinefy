import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/utils/enums/request_state_enum.dart';
import 'package:movie_app/movies/presentation/controller/favourit cubit/Favorites_cubit.dart';
import 'package:movie_app/movies/presentation/controller/favourit cubit/Favorites_state.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc/movie_details_bloc.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc/movie_details_state.dart';
import 'package:movie_app/movies/presentation/screens/favorite_movies_screen.dart';
import 'package:movie_app/movies/presentation/screens/watch_movie_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/constants.dart';

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      buildWhen: (previous, current) =>
      previous.movieDetailsRequest != current.movieDetailsRequest,
      builder: (context, state) {
        if (state.movieDetailsRequest == RequestState.loading) {
          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 245.h,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                shimmerLine(width: 180.w, height: 25.h),
                SizedBox(height: 10.h),
                shimmerLine(width: 280.w, height: 25.h),
                SizedBox(height: 10.h),
                shimmerLine(width: 480.w, height: 250.h),
                SizedBox(height: 30.h),
              ],
            ),
          );
        } else if (state.movieDetailsRequest == RequestState.success) {
          final movieDetails = state.movieDetails;
          return Column(
            children: [
              FadeIn(
                duration: const Duration(milliseconds: 500),
                child: SizedBox(
                  width: double.infinity,
                  height: 220.h,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: Constants.imageUrl(movieDetails.backdropPath),
                        fit: BoxFit.cover,
                      ),

                      Positioned(
                        top: 10.h,
                        left: 10.w,
                        child: Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black54,
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              size: 22.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),


                      Positioned(
                        top: 10.h,
                        right: 10.w,
                        child: Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black54,
                          ),
                          child: Center(
                            child: BlocBuilder<FavoritesCubit, FavoritesState>(
                              builder: (context, favState) {
                                final isFavorite = favState.favoriteIds
                                    .contains(movieDetails.id);

                                return IconButton(
                                  onPressed: () {
                                    if (isFavorite) {
                                      context
                                          .read<FavoritesCubit>()
                                          .removeFromFavourites(
                                          movieDetails.id);

                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.black,
                                          content: Text(
                                            'Removed ${movieDetails.title} from favorites',
                                            style: GoogleFonts.poppins(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      context
                                          .read<FavoritesCubit>()
                                          .addMovieToFavorites(
                                        movieDetails.id,
                                        movieDetails.title,
                                        movieDetails.backdropPath,
                                      );

                                      ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                          ..showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.black,
                                          content: Text(
                                            'Added ${movieDetails.title} to favorites',
                                            style: GoogleFonts.poppins(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                          action: SnackBarAction(
                                            label: "View",
                                            textColor:
                                            const Color(0xffD10909),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  child:
                                                  const FavoriteMoviesScreen(),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    CupertinoIcons.heart_fill,
                                    size: 32.sp,
                                    color:
                                    isFavorite ? Colors.red : Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FadeIn(
                  duration: const Duration(milliseconds: 700),
                  child: movieInfoSection(context, state),
                ),
              ),
            ],
          );
        } else if (state.movieDetailsRequest == RequestState.error) {
          return Center(
            child: Text(
              state.movieDetailsMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget shimmerLine({required double width, required double height}) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: width,
        height: height,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[850]!,
          highlightColor: Colors.grey[800]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.sp),
            ),
          ),
        ),
      ),
    );
  }

  Widget movieInfoSection(BuildContext context, MovieDetailsState state) {
    final movie = state.movieDetails;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            color: const Color(0xffCECED0),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff424242),
                borderRadius: BorderRadius.circular(2.5.sp),
                border: Border.all(color: const Color(0xff36363A)),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Text(
                  movie.releaseDate.substring(0, 4),
                  style: GoogleFonts.poppins(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffC5C5C5),
                  ),
                ),
              ),
            ),
            SizedBox(width: 15.w),
            Row(
              children: [
                Icon(Icons.star,
                    color: const Color(0xffFFC100), size: 20.sp),
                SizedBox(width: 5.w),
                Text(
                  '${movie.voteAverage.toStringAsFixed(1)} (${movie.voteCount})',
                  style: GoogleFonts.poppins(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffC5C5C5),
                  ),
                ),
              ],
            ),
            SizedBox(width: 24.w),
            Text(
              '${movie.runtime} m ',
              style: GoogleFonts.poppins(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xff949499),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Text(
          movie.overview,
          style: GoogleFonts.poppins(
            fontSize: 14.1.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xffA7A7AB),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          'Genres: ${movie.genres.map((g) => g.name).join(', ')}',
          style: GoogleFonts.poppins(
            fontSize: 11.5.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff939398),
          ),
        ),
        SizedBox(height: 20.h),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xffD10909),
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.topToBottom,
                  duration: const Duration(milliseconds: 300),
                  child: WatchMovieScreen(
                    movieTitle: movie.title,
                    movieID: movie.id,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.movie_filter_sharp,
                      color: Colors.white, size: 22.sp),
                  SizedBox(width: 5.w),
                  Text(
                    'Watch Movie Now',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
