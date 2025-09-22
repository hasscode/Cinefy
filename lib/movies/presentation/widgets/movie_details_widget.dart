import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/utils/enums/request_state_enum.dart';

import 'package:movie_app/movies/presentation/controller/movie_details_bloc/movie_details_state.dart';
import 'package:movie_app/movies/presentation/screens/watch_movie_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:shimmer/shimmer.dart';

import '../../../core/utils/constants.dart';
import '../controller/movie_details_bloc/movie_details_bloc.dart';

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc,MovieDetailsState>(
      buildWhen: (previous,current)=> previous.movieDetailsRequest !=current.movieDetailsRequest,
      builder: (context,state){
        if(state.movieDetailsRequest == RequestState.loading){
          return FadeIn(
            duration: Duration(milliseconds: 500),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 245.h,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                    child: Container(
                      margin: const EdgeInsets.only(right: 8.0),

                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 180.w,
                    height: 25.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8.0),

                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0.sp),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 280.w,
                    height: 25.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8.0),

                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0.sp),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 480.w,
                    height: 250.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8.0),

                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0.sp),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          );

        }
        else if (state.movieDetailsRequest == RequestState.success){

          return Column(
            children: [
              FadeIn(
                duration: Duration(milliseconds: 500),
                child: SizedBox(
                  width: double.infinity,
                  height: 220.h,
                  child: Stack(
                    children:[
                      CachedNetworkImage(
                      imageUrl: Constants.imageUrl(state.movieDetails.backdropPath),
                      fit: BoxFit.cover,
                    ),
                      Positioned(
                        top: 10.h,
                        left: 10.w,
                        child: Container(

                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            backgroundBlendMode: BlendMode.hardLight,
                            borderRadius: BorderRadius.circular(30)
                            ,color: Colors.black54,

                          ),
                          child: Center(
                              child:IconButton(onPressed: (){Navigator.pop(context);}, icon:  Icon(Icons.arrow_back_ios_new,size: 22.sp,color: Colors.white,))
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
                            backgroundBlendMode: BlendMode.hardLight,
                            borderRadius: BorderRadius.circular(30)
                            ,color: Colors.black54,

                          ),
                          child: Center(
                              child:IconButton(onPressed: (){}, icon:  Icon(CupertinoIcons.heart_fill,size: 32.sp,color: Colors.white,))
                          ),
                        ),
                      ),
                  ]),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FadeIn(
                  duration:  Duration(milliseconds: 700),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(

                        state.movieDetails.title,
                        style: GoogleFonts.poppins(

                          fontSize: 20.sp,
                          color: Color(0xffCECED0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xff424242),
                              borderRadius: BorderRadius.circular(2.5.sp),
                              border: Border.all(color: Color(0xff36363A)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 4,
                              ),
                              child: Text(
                                (state.movieDetails.releaseDate).substring(0,4),
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5.sp,

                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffC5C5C5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Color(0xffFFC100),
                                size: 20.sp,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                             '${(state.movieDetails.voteAverage.toString()).substring(0,3)} (${state.movieDetails.voteCount})',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5.sp,

                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffC5C5C5),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 24.w),
                          Text(
                            '${state.movieDetails.runtime.toString()} m ',
                            style: GoogleFonts.poppins(
                              fontSize: 13.5.sp,

                              fontWeight: FontWeight.w400,
                              color: Color(0xff949499),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        state.movieDetails.overview,
                        style: GoogleFonts.poppins(
                          fontSize: 14.1.sp,

                          fontWeight: FontWeight.w400,
                          color: Color(0xffA7A7AB),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                          'Genres: ${state.movieDetails.genres.map((g) => g.name).join(', ')}',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5.sp,

                          fontWeight: FontWeight.w500,
                          color: Color(0xff939398),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              overlayColor:Colors.white,
                            backgroundColor: Color(0xffD10909),
                          ),
                          onPressed: () {
                            Navigator.push(context, PageTransition(
                              type: PageTransitionType.topToBottom, // slideRight, slideLeft, scale, rotate...
                              duration: const Duration(milliseconds: 300),
                              child: WatchMovieScreen(movieTitle:state.movieDetails.title ,movieID: state.movieDetails.id,),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.movie_filter_sharp ,color:Colors.white,size: 22.sp,),
                                SizedBox(width: 5.w,),
                                Text('Watch Movie Now',style: GoogleFonts.poppins(color: Colors.white,fontSize: 15.5.sp,fontWeight: FontWeight.w600),),

                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                    ],
                  ),
                ),
              ),


            ],
          );
        }
        else if (state.movieDetailsRequest ==RequestState.error){
          return Center(child: Text(state.movieDetailsMessage,style: TextStyle(color: Colors.red),));
        }
        return Text('Movie Details');
      }
    );
  }
}
