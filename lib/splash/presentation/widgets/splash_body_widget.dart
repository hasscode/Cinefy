import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/styles/app_images.dart';
class SplashBodyWidget extends StatelessWidget {
  const SplashBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.starsBackgroundImageBlur),fit: BoxFit.cover)
        ),
        child: Column(


          children: [
            SizedBox(height: 335.h,),
            FadeIn(duration: Duration(milliseconds: 1000), child: Image.asset(AppImages.logoImage,width: 250.w)),
            Spacer(),
            FadeIn(delay: Duration(milliseconds: 100), child: Text('"Escape into Cinema"',style: GoogleFonts.oswald(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),)),
            SizedBox(height: 40.h,),
          ],
        ),
      ),
    );
  }
}
