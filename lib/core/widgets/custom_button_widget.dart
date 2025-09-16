import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.title,
    required this.width,
    required this.height,
    required this.onTap,
    required this.colorButton,
    required this.colorText,

  });
  final String title;
  final double width;
  final double height;
  final void Function()? onTap;
  final Color? colorText;
  final Color? colorButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(15)
       ),
color: colorButton,
        elevation: 10,
        shadowColor: colorButton,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(15.sp),
            color: colorButton,
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: colorText,
              )
            ),
          ),
        ),
      ),
    );
  }
}
