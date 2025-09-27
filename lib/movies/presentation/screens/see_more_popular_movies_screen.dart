import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/core/utils/enums/request_state_enum.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_bloc.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_state.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_events.dart';
import 'package:movie_app/core/widgets/page_number_button_widget.dart';
import 'package:movie_app/core/widgets/movie_info_item_widget.dart';
import 'package:shimmer/shimmer.dart';

class SeeMorePopularMoviesScreen extends StatefulWidget {
  const SeeMorePopularMoviesScreen({super.key, required this.title});

  final String title;

  @override
  State<SeeMorePopularMoviesScreen> createState() =>
      _SeeMorePopularMoviesScreenState();
}

class _SeeMorePopularMoviesScreenState
    extends State<SeeMorePopularMoviesScreen> {
  final ScrollController scrollController = ScrollController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sL<MoviesBloc>()..add(GetPopularMovies(1)),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(
            widget.title,
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
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.starsBackgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocBuilder<MoviesBloc, MoviesState>(
              buildWhen: (previous, current) =>
                  previous.popularState != current.popularState ||
                  previous.popularMovies != current.popularMovies,
              builder: (context, state) {
                if (state.popularState == RequestState.loading) {
                  return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, i) => Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8.0),
                              height: 160.0.h,
                              width: 120.0.w,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8.0.sp),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  SizedBox(height: 25.h),
                                  Container(
                                    margin: const EdgeInsets.only(right: 8.0),
                                    height: 25.0.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(
                                        8.0.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    margin: const EdgeInsets.only(right: 8.0),
                                    height: 95.0.h,

                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(
                                        8.0.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state.popularState == RequestState.error) {
                  return Center(
                    child: Text(
                      state.popularMessage,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  );
                } else if (state.popularState == RequestState.success) {
                  return CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(child: SizedBox(height: 10)),
                      SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            'Page $currentPage',
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,

                              fontWeight: FontWeight.w700,
                              color: Color(0xffC5C5C5),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 10)),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 8,
                            ),
                            child: MovieInfoItemWidget(
                              movie: state.popularMovies[i],
                            ),
                          ),
                          childCount: state.popularMovies.length,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: [
                              Text(
                                'Pages :',
                                style: GoogleFonts.poppins(
                                  fontSize: 13.5.sp,

                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffC5C5C5),
                                ),
                              ),

                              Expanded(
                                child: SizedBox(
                                  height: 55.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 200,
                                    itemBuilder: (context, i) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 8,
                                      ),
                                      child: PageNumberButtonWidget(
                                        onPageSelected: (pn) {
                                          context.read<MoviesBloc>().add(GetPopularMovies(pn));
                                          setState(() {
                                            currentPage = pn;
                                          });
                                        },
                                        isSelected: (i+1)==currentPage,
                                        scrollController: scrollController,

                                        pageNumber: i + 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
