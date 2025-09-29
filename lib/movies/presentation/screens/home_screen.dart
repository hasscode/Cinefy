import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/auth/presentation/controller/login%20cubit/login_cubit.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/movies/presentation/screens/see_more_popular_movies_screen.dart';
import 'package:movie_app/movies/presentation/screens/see_more_top_rated_movies_screen.dart';
import 'package:movie_app/movies/presentation/widgets/home_app_bar_widget.dart';
import 'package:movie_app/movies/presentation/widgets/now_playing_movies.dart';
import 'package:movie_app/movies/presentation/widgets/popular_movies_widget.dart';
import 'package:movie_app/movies/presentation/widgets/recommended_movies_widget.dart';
import 'package:movie_app/movies/presentation/widgets/top_rated_movies_widget.dart';

import 'package:shimmer/shimmer.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/dummy.dart';
import '../controller/movies_bloc/movies_bloc.dart';
import '../controller/movies_bloc/movies_events.dart';
import '../widgets/movies_category_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sL<MoviesBloc>()
          ..add(GetNowPlayingMovies())
          ..add(GetPopularMovies(1))
          ..add(GetTopRatedMovies(1))
          ..add(GetRecommendationsForYou())
          ,),
        BlocProvider(create: (context)=> LoginCubit(sL()))
      ],

      child: Scaffold(
       backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.starsBackgroundImageBlur),fit: BoxFit.cover)
            ),
            child: SingleChildScrollView(
              key: const Key('movieScrollView'),
              child: Stack(
                children:[ Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
          
                    NowPlayingMovies(),

                    MoviesCategoryHeaderWidget(title: 'Popular',screen: SeeMorePopularMoviesScreen(title: 'Popular'),isForYou: false),
                    PopularMoviesWidget(),
                    MoviesCategoryHeaderWidget(title: 'For You',screen: SizedBox.shrink(),isForYou: true,),
                    RecommendedMoviesWidget(),
                    MoviesCategoryHeaderWidget(title: 'Top Rated',screen: SeeMoreTopRatedMoviesScreen(title: 'Top Rated'),isForYou: false),
                    TopRatedMoviesWidget(),
                     SizedBox(height: 50.0.h),
                  ],
                ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical :10,horizontal: 12.0),
                    child: HomeAppBarWidget(),
                  )
          
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
