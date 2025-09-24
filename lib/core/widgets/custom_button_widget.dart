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
    return SizedBox(

      width: width,
      height:height,
      child: ElevatedButton(

        style: ElevatedButton.styleFrom(
          overlayColor: colorButton,
          elevation: 12,
          shadowColor: colorButton,
          backgroundColor: colorButton,
          shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(15.r)
          ),
        ),
        onPressed: onTap,
        child:Center(
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
    );
  }
}
