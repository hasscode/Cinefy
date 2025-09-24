import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/auth/presentation/screens/sign_up_screen.dart';
import 'package:movie_app/core/widgets/custom_button_widget.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:page_transition/page_transition.dart';

import 'login_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity.w,
            height: double.infinity.h,
            child: Image.asset(AppImages.starsBackgroundImage,fit: BoxFit.cover,),
          ),

          Positioned(
            top: 0,
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // fromLTRB
                    Colors.black,
                    Colors.black,
                    Colors.black,
                    Colors.transparent,
                  ],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(AppImages.moviesPosterImage, height: 460.h),
            ),
          ),
          Positioned(
            left: 60.w,
            top: 350.h,
            child: FadeIn(
              delay: Duration(milliseconds: 900),
              child: SizedBox(
                child: Image.asset(AppImages.logoImage, width: 250.w),
              ),
            ),
          ),
          Positioned(
            bottom: 90.h,
            left: 45.w,
            child: FadeIn(
              delay: Duration(milliseconds: 1200),
              child: Column(
                children: [
                  CustomButtonWidget(title: 'Create New Account', width: 300.w, height: 50.h, onTap: (){

                    Navigator.push(context, PageTransition(
                      type: PageTransitionType.bottomToTop, // slideRight, slideLeft, scale, rotate...
                      duration: const Duration(milliseconds: 300),
                      child: SignUpScreen(),
                    ));
                  },colorButton: Color(0xffF6F4F4),colorText:  Color(0xff9C231D)),
                  SizedBox(height: 20.h,),
                  CustomButtonWidget(title: 'Login', width: 300.w, height: 50.h, onTap: (){Navigator.push(context, PageTransition(
                    type: PageTransitionType.bottomToTop, // slideRight, slideLeft, scale, rotate...
                    duration: const Duration(milliseconds: 300),
                    child: LoginScreen(),
                  ));},colorButton: Color(0xff9C231D),colorText: Colors.white,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
