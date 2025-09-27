import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/movies/presentation/controller/favourit%20cubit/Favorites_cubit.dart';
import 'package:movie_app/movies/presentation/controller/favourit%20cubit/Favorites_state.dart';
import 'package:movie_app/movies/presentation/widgets/movie_poster_item_widget.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sL<FavoritesCubit>()..getFavoriteMovies(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(
            'Your Favorites',
            style: GoogleFonts.poppins(
              fontSize: 17.5.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xffBFBFBF),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.starsBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state is GetFavoritesSuccess) {
                if (state.favorites.isEmpty) {
                  return Column(

                    children: [
                      SizedBox(height: 100.h,),
                      Image.asset(AppImages.noFavoritesImage,width: 180.w,),
                      SizedBox(height: 20.h,),
                      Text(
                        'No favorites here… yet!',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 17.5.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        'Explore and add what you like',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 17.5.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                }
                else {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: GridView.builder(
                      itemCount: state.favorites.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: .6,
                          crossAxisSpacing: 2

                      ), itemBuilder: (BuildContext context, int i) =>Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: MoviePosterItemWidget(movie: state.favorites[i]),
                    ),


                    ),
                  );
                }
              } else if (state is GetFavoritesLoading) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: .6,
                      crossAxisSpacing: 2,
                    ),
                    itemBuilder: (BuildContext context, int i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Shimmer.fromColors(
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
                      ),
                    ),
                  ),
                );
              } else if (state is GetFavoritesFailure) {
                return Text(state.message, style: TextStyle(color: Colors.red));
              }
              return Text('', style: TextStyle(color: Colors.white));
            },
          ),
        ),
      ),
    );
  }
}
