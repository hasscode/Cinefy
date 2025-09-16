import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../domain/entities/movie.dart';
import '../screens/see_more_popular_movies_screen.dart';
class MoviesCategoryHeaderWidget extends StatelessWidget {
  const MoviesCategoryHeaderWidget({super.key,required this.title,required this.screen});
final String title ;
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(

            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              overlayColor: Color(0xffD10909)
            ),
            onPressed: () {
              Navigator.push(context, PageTransition(
                type: PageTransitionType.rightToLeft, // slideRight, slideLeft, scale, rotate...
                duration: const Duration(milliseconds: 300),
                child:screen,
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('See All',style: GoogleFonts.poppins(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
