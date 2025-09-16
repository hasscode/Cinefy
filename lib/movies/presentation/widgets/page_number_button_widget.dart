import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/movies_bloc/movies_bloc.dart';
import '../controller/movies_bloc/movies_events.dart';
class PageNumberButtonWidget extends StatelessWidget {
  const PageNumberButtonWidget({super.key,required this.pageNumber,required this.isPopular,required this.scrollController,required this.onPageSelected,required this.isSelected});
final int pageNumber ;
final bool isPopular;
final bool isSelected ;
  final ScrollController scrollController;
  final void Function(int page) onPageSelected;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.sp),
        color: isSelected ? Colors.white60:Colors.transparent,
      ),

      child: TextButton(

        style: TextButton.styleFrom(
          overlayColor:Colors.white,
        ),
        onPressed: () {
          isPopular ?context.read<MoviesBloc>().add(GetPopularMovies(pageNumber)):context.read<MoviesBloc>().add(GetTopRatedMovies(pageNumber));
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
          onPageSelected(pageNumber);
        },

        child: Text(
          (pageNumber).toString(),
          style: GoogleFonts.poppins(
            fontSize: 16.5.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xffAB0808),
          ),
        ),
      ),
    );
  }
}
