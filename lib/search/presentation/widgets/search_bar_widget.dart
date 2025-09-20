import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/search cubit/search_cubit.dart';
class SearchBarWidget extends StatelessWidget {
 const SearchBarWidget({super.key,required this.textEditingController,required this.currentPage});
final TextEditingController textEditingController;
final int currentPage ;
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      textStyle:MaterialStateProperty.all(
          GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
              color: Colors.black
          )) ,
      hintText: 'search for any movie',
      hintStyle:  MaterialStateProperty.all(
          GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: Colors.black
          )),
      controller: textEditingController,
      backgroundColor: MaterialStateProperty.all(Color(0xffF8F8F8)),
      leading: Icon(CupertinoIcons.search),
    onChanged: (text) {
    if (text.isNotEmpty) {
    context.read<SearchCubit>().getMoviesBySearch(text,currentPage);
    }},
    );
  }
}
