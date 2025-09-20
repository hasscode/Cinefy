import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/search/presentation/controller/search%20cubit/search_cubit.dart';

import '../../movies/presentation/controller/movies_bloc/movies_bloc.dart';
import '../../movies/presentation/controller/movies_bloc/movies_events.dart';
class PageNumberButtonWidget extends StatelessWidget {
  final int pageNumber;
  final bool isSelected;
  final ScrollController scrollController;
  final void Function(int) onPageSelected;

  const PageNumberButtonWidget({
    super.key,
    required this.pageNumber,
    required this.isSelected,
    required this.scrollController,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shadowColor:isSelected ?Colors.white:Colors.transparent,
        elevation: 1
      ),
      onPressed: () {
        onPageSelected(pageNumber);
        scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
      child: Text(
        (pageNumber).toString(),
        style: GoogleFonts.poppins(
          fontSize: 16.5.sp,
          fontWeight: FontWeight.bold,
          color: Color(0xffAB0808),
        ),
      ),
    );
  }
}
