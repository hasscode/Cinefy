import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/core/widgets/custom_text_form_field.dart';
import 'package:movie_app/search/presentation/controller/search%20cubit/search_cubit.dart';
import 'package:movie_app/search/presentation/controller/search%20cubit/search_state.dart';
import 'package:movie_app/search/presentation/widgets/search_bar_widget.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/dummy.dart';
import '../../../core/widgets/page_number_button_widget.dart';
import '../../../core/widgets/movie_info_item_widget.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>sL<SearchCubit>(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.starsBackgroundImage),fit:BoxFit.cover )

            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
                  child: SearchBarWidget(textEditingController: searchController,currentPage: currentPage,),
                ),
                Expanded(
                  child: BlocBuilder<SearchCubit,SearchState>(
                     builder: (context,state){
                       if(state is SearchInitial){
                         return Center(
                           child: Text(
                             'Type something to search...',
                             style: TextStyle(color: Colors.white),
                           ),
                         );
                       }
                       else if(state is SearchLoading){
                         return Center(child: CircularProgressIndicator(color: Color(0xffD10909),));
                       }
                       else if (state is SearchFailure){
                         return Center(child: Text(state.errMessage,style: TextStyle(color: Colors.red),));
                       }
                       else if (state is SearchSuccess){
                         if(state.fullSearchResponse.movies.isEmpty){
                           return Center(child: Text('No Results',style: TextStyle(color: Colors.red),));
                         }
                         else{
                           return CustomScrollView(
                             controller: scrollController,
                             slivers: [

                               SliverToBoxAdapter(child: SizedBox(height: 10)),
                               // SliverToBoxAdapter(
                               //   child: Center(
                               //     child: Text(
                               //       'Page $currentPage',
                               //       style: GoogleFonts.poppins(
                               //         fontSize: 20.sp,
                               //
                               //         fontWeight: FontWeight.w700,
                               //         color: Color(0xffC5C5C5),
                               //       ),
                               //     ),
                               //   ),
                               // ),
                               SliverToBoxAdapter(child: SizedBox(height: 10)),
                               SliverList(
                                 delegate: SliverChildBuilderDelegate(
                                       (context, i) => Padding(
                                     padding: const EdgeInsets.symmetric(
                                       horizontal: 5,
                                       vertical: 8,
                                     ),
                                     child: MovieInfoItemWidget(
                                       movie: state.fullSearchResponse.movies[i],
                                     ),
                                   ),
                                   childCount:state.fullSearchResponse.movies.length,
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
                                             itemCount: state.fullSearchResponse.numberOfPages,
                                             itemBuilder: (context, i) => Padding(
                                               padding: const EdgeInsets.symmetric(
                                                 horizontal: 5,
                                                 vertical: 8,
                                               ),
                                               child: PageNumberButtonWidget(
                                                 onPageSelected: (pn) {
                                                   context.read<SearchCubit>().getMoviesBySearch(
                                                      searchController.text,
                                                      pn
                                                   );
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
                       }
                       else {
                         return Text('searh page');
                       }


                     },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
