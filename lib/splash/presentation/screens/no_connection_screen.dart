import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/styles/app_images.dart';
class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image:DecorationImage(image:  AssetImage(AppImages.starsBackgroundImage),fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.h,),
              Image.asset(AppImages.noConnectionImage,width: 200.w,),
              SizedBox(height: 100.h,),
              Text('Check Your Internet Connection',style: GoogleFonts.poppins(fontSize: 16.sp,fontWeight: FontWeight.w600,color: Color(0xffF8F8F8)),)
            ],
          ),
        ),
      ),
    );
  }
}
