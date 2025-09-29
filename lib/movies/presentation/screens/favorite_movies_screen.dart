import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/core/widgets/custom_button_widget.dart';
import 'package:movie_app/movies/presentation/controller/favourit%20cubit/Favorites_cubit.dart';
import 'package:movie_app/movies/presentation/controller/favourit%20cubit/Favorites_state.dart';
import 'package:movie_app/movies/presentation/widgets/movie_poster_item_widget.dart';
import 'package:movie_app/search/presentation/screens/search_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Your Favorites',style: GoogleFonts.poppins(fontSize: 20.sp,fontWeight: FontWeight.w600,color: Colors.white),),
        centerTitle: true,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
      ),
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.starsBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state.status == FavoritesStatus.loading) {
              return GridView.builder(
                itemCount: 12,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: .6,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                    child: Container(
                      height: 170.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                    ),
                  ),
                ),
              );
            } else if (state.status == FavoritesStatus.failure) {
              return Center(
                child: Text(
                  state.errorMessage ?? "Error",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state.movies.isEmpty) {
              return SlideInDown(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(AppImages.noFavoritesImage, width: 180.w),
                    const SizedBox(height: 50),
                    Text(
                      "No favorites yet",
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: CustomButtonWidget(
                        title: 'Find them ,Add now 🔎',
                        width: double.infinity,
                        height: 60.h,
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 400),
                              child: SearchScreen(),
                            ),
                          );
                        },
                        colorButton: Color(0xffD10909),
                        colorText: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(6),
              itemCount: state.movies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: .6,
                crossAxisSpacing: 2,
              ),
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ElasticInLeft(child: MoviePosterItemWidget(movie: state.movies[i])),
              ),
            );
          },
        ),
      ),
    );
  }
}
