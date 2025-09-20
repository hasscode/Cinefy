import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key,required this.textEditingController,required this.obscureText,required this.title,required this.hintText});
final TextEditingController textEditingController ;
  final bool obscureText;
  final String title;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(title,style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xffF8F8F8)
          ),),
        ),
        SizedBox(height: 10.h,),
        TextFormField(

          style: GoogleFonts.poppins(color: Color(0xffF8F8F8),fontSize: 14),
          controller: textEditingController,
          cursorColor: Colors.white,
          obscureText: obscureText,
          decoration: InputDecoration(
            errorStyle:  TextStyle(
    height: 0,
    fontSize: 12.sp,
    color: Colors.red,
    ),
hintText: hintText,
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.sp),
              borderSide: BorderSide(color: Color(0xffCFCFCF)),

            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.sp),
              borderSide: BorderSide(color: Color(0xffF8F8F8)),

            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.sp),
              borderSide: BorderSide(color: Color(0xffCFCFCF)),

            )
          ),
          validator: (v) {
            if (v == null || v.isEmpty) {
              return 'this field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
