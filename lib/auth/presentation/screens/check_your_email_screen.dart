import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/auth/presentation/screens/login_screen.dart';
import 'package:movie_app/core/styles/app_images.dart';

import '../../../core/widgets/custom_button_widget.dart';
class CheckYourEmailScreen extends StatelessWidget {
  const CheckYourEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
        
            image: DecorationImage(image: AssetImage(AppImages.starsBackgroundImage),fit: BoxFit.cover)
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30.h),
                FadeIn(child: Image.asset(AppImages.logoImage, width: 200.w)),
                SizedBox(height: 30.h),
                ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        // fromLTRB
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors.transparent,
                      ],
                    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.lighten,
                  child: IntrinsicHeight(
                    child: GlassmorphicContainer(
                      width: 340.w,

                      borderRadius: 20.sp,
                      blur: 1.5,
                      alignment: Alignment.bottomCenter,
                      border: 0,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFffffff).withOpacity(0.1),
                          Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: [0.1, 1],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFffffff).withOpacity(0.5),
                          Color((0xFFFFFFFF)).withOpacity(0.5),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'Check Your Email And Reset Password',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                                color: Color(0xffF6F4F4),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: CustomButtonWidget(
                          title: 'Login',
                          width: double.infinity.w,
                          height: 50.h,
                          onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          },
                          colorButton: Color(0xff9C231D),
                          colorText: Color(0xffF6F4F4),
                        ),
                      ),
                          SizedBox(height: 30.h),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
