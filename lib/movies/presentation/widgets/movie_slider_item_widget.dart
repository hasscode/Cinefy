import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/movies/domain/entities/movie.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/utils/constants.dart';
import '../screens/movie_details_screen.dart';
class MovieSliderItemWidget extends StatelessWidget {
  const MovieSliderItemWidget({super.key,required this.movie});
final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // fromLTRB
                Colors.transparent,
                Colors.black,
                Colors.black,
                Colors.transparent,
              ],
              stops: [0, 0.3, 0.5, 1],
            ).createShader(
              Rect.fromLTRB(0, 0, rect.width, rect.height),
            );
          },
          blendMode: BlendMode.dstIn,
          child: CachedNetworkImage(
            height: 350.0.h,
            imageUrl: Constants.imageUrl(movie.backdropPath!),
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(

            children: [

              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Container(

                      height: 35.h,
                      width: 80.w,
                      decoration: BoxDecoration(

                        backgroundBlendMode: BlendMode.hardLight,
                        borderRadius: BorderRadius.circular(20)
                        ,color: Colors.grey,

                      ),
                      child: Center(
                        child: Text('trending', style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 13.sp,
                        ),),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, PageTransition(
                          opaque: true,
                          type: PageTransitionType.fade, // slideRight, slideLeft, scale, rotate...
                          duration: const Duration(milliseconds: 200),
                          child:  MovieDetailsScreen(movieID: movie.id),
                        ));
                      },
                      child: Container(

                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          backgroundBlendMode: BlendMode.hardLight,
                          borderRadius: BorderRadius.circular(50)
                          ,color: Colors.grey,

                        ),
                        child: Center(
                            child: Icon(Icons.play_arrow_sharp,size: 45.sp,color: Colors.white70,)
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
