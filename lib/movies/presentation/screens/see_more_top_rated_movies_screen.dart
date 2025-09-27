import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc/movies_events.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/styles/app_images.dart';
import '../../../core/utils/enums/request_state_enum.dart';
import '../controller/movies_bloc/movies_bloc.dart';
import '../controller/movies_bloc/movies_state.dart';
import '../../../core/widgets/page_number_button_widget.dart';
import '../../../core/widgets/movie_info_item_widget.dart';
class SeeMoreTopRatedMoviesScreen extends StatefulWidget {
  const SeeMoreTopRatedMoviesScreen({super.key,required this.title});

  final String title ;

  @override
  State<SeeMoreTopRatedMoviesScreen> createState() => _SeeMoreTopRatedMoviesScreenState();
}

class _SeeMoreTopRatedMoviesScreenState extends State<SeeMoreTopRatedMoviesScreen> {

  int currentPage = 1;
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sL<MoviesBloc>()..add(GetTopRatedMovies(1)),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontSize: 17.5,
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.starsBackgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocBuilder<MoviesBloc, MoviesState>(
              buildWhen: (previous, current) =>
              previous.topRatedState != current.topRatedState ||
                  previous.topRatedMovies != current.topRatedMovies ,

              builder: (context, state) {
                if (state.topRatedState == RequestState.loading) {
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
                                  SizedBox(height: 25.h,),
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
                                  SizedBox(height: 10.h,),
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
                } else if (state.topRatedState == RequestState.error) {
                  return Center(
                    child: Text(
                      state.topRatedMessage,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  );
                } else if (state.topRatedState == RequestState.success) {
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
                              movie: state.topRatedMovies[i],
                            ),
                          ),
                          childCount: state.topRatedMovies.length,
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
                                        isSelected: (i+1)==currentPage,
                                        onPageSelected: (pn){
                                          context.read<MoviesBloc>().add(GetTopRatedMovies(pn));
                                          setState(() {
                                            currentPage =pn;
                                          });
                                        },
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
