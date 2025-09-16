import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/core/utils/enums/request_state_enum.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc/movie_details_state.dart';
import 'package:movie_app/movies/presentation/widgets/cast_details_item_widget.dart';
import 'package:movie_app/movies/presentation/widgets/movie_details_widget.dart';
import 'package:movie_app/movies/presentation/widgets/movie_poster_item_widget.dart';
import 'package:movie_app/movies/presentation/widgets/movie_recommendations_widget.dart';
import 'package:shimmer/shimmer.dart';

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
      create: (context)=> sL<MovieDetailsBloc>()..add(GetMovieRecommendations(movieID)) ..add(GetMovieDetails(movieID))..add(GetMovieCredits(movieID)),
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

                SliverToBoxAdapter(child: SizedBox(height: 15.h,
                ),),
                SliverToBoxAdapter(child: Center(child: Text('Cast',style: GoogleFonts.poppins(fontSize: 18.sp,fontWeight: FontWeight.w500,color:Color(0xffB6B6BA) ),)),),
                SliverToBoxAdapter(child: SizedBox(height: 15.h,
                ),),
                SliverToBoxAdapter(
                  child: BlocBuilder<MovieDetailsBloc,MovieDetailsState>(
                    buildWhen: (previous,after)=>previous.movieCreditsState !=after.movieCreditsState,
                    builder: (context,state){
                      if (state.movieCreditsState ==RequestState.loading){
                        return SizedBox(

                          height: 205.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, i) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 8,
                              ),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[850]!,
                                highlightColor: Colors.grey[800]!,
                                child: Column(
                                  children: [
                                    Container(

                                      margin: const EdgeInsets.only(right: 8.0),
                                      height: 60.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(30.sp),
                                      ),
                                    ),
                                    SizedBox( height: 5.h,),
                                    Container(

                                      margin: const EdgeInsets.only(right: 8.0),
                                      height: 30.h,
                                      width: 75.w,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(30.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );

                      }
                      if (state.movieCreditsState ==RequestState.success){
                        return SizedBox(

                          height: 205.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.movieCredits.length,
                            itemBuilder: (context, i) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 8,
                              ),
                              child: CastDetailsItemWidget(credit: state.movieCredits[i]),
                            ),
                          ),
                        );

                      }
                      if(state.movieCreditsState ==RequestState.error){
                        return Center(child:  Text(state.movieCreditsMessage,style: GoogleFonts.poppins(color: Colors.red),),);
                      }
                      return Center(child: Text('Credits',style: TextStyle(color: Colors.white),));
                    },
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 15.h,
                ),),
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
