import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/movies/presentation/screens/movie_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../styles/app_images.dart';
import '../utils/constants.dart';
import '../../movies/domain/entities/movie.dart';
class MovieInfoItemWidget extends StatelessWidget {
  const MovieInfoItemWidget({super.key,required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, PageTransition(
          type: PageTransitionType.leftToRight, // slideRight, slideLeft, scale, rotate...
          duration: const Duration(milliseconds: 300),
          child: MovieDetailsScreen(movieID: movie.id),
        ));
      },
      child: Container(
        width: double.infinity,
        height: 160.h,
        decoration: BoxDecoration(
            color: Color(0xff303030),
            borderRadius: BorderRadius.circular(8.sp)
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius:
               BorderRadius.all(Radius.circular(5.0.sp)),
              child: CachedNetworkImage(
                width: 90.w,
                height: 150.h,
                fit: BoxFit.cover,
                imageUrl: movie.backdropPath!='https://image.tmdb.org/t/p/w500'? Constants.imageUrl(movie.backdropPath!):AppImages.movieImage,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    height: 170.0.h,
                    width: 120.0.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title??'',overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w400,color: Color(0xffBFBFBF)),),
                  SizedBox(height: 8.h,),
                  Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffCD4A4A),
                        borderRadius: BorderRadius.circular(2.5.sp),
                        border: Border.all(color: Color(0xff36363A)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        child:Text(
                          (movie.releaseDate != null && movie.releaseDate.length >= 4)
                              ? movie.releaseDate.substring(0, 4)
                              : "N/A",
                          style: GoogleFonts.poppins( fontSize: 12.5.sp,

                            fontWeight: FontWeight.w700,
                            color: Color(0xffC5C5C5),),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color(0xffFFC100),
                          size: 20.sp,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          (movie.voteAvg.toString()).substring(0,3),
                          style: GoogleFonts.poppins(
                            fontSize: 12.5.sp,

                            fontWeight: FontWeight.w300,
                            color: Color(0xffC5C5C5),
                          ),
                        ),
                      ],
                    ),

                  ],),
                   SizedBox(height: 15.h,),
                  Text(
                    movie.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(

                      fontSize: 14.1.sp,

                      fontWeight: FontWeight.w400,
                      color: Color(0xffA7A7AB),
                    ),
                  ),
                ],

              ),
            ),
          )

        ],),

      ),
    );
  }
}
