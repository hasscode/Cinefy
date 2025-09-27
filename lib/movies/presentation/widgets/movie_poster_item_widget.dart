import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/movies/domain/entities/movie.dart';
import 'package:movie_app/movies/presentation/screens/movie_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/constants.dart';
import '../controller/favourit cubit/Favorites_cubit.dart';
class MoviePosterItemWidget extends StatelessWidget {
  const MoviePosterItemWidget({super.key,required this.movie});
final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
       Navigator.push(context, PageTransition(
         type: PageTransitionType.fade, // slideRight, slideLeft, scale, rotate...
         duration: const Duration(milliseconds: 300),
         child: MovieDetailsScreen(movieID: movie.id),
       )).then((_) {
         BlocProvider.of<FavoritesCubit>(context).getFavoriteMovies();
       });


        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xff7C8587),width: .3),
            borderRadius:        BorderRadius.all(Radius.circular(5.sp)),
          ),
          child: ClipRRect(

            borderRadius:
             BorderRadius.all(Radius.circular(5.sp)),
            child: CachedNetworkImage(

              width: 120.0.w,
              fit: BoxFit.cover,
              imageUrl:movie.backdropPath!='https://image.tmdb.org/t/p/w500'? Constants.imageUrl(movie.backdropPath!):AppImages.movieImage,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[850]!,
                highlightColor: Colors.grey[800]!,
                child: Container(

                  width: 120.0.w,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0.sp),
                  ),
                ),
              ),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
            )
          ),
        ),
      ),
    );
  }
}
