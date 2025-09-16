import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/auth/presentation/controller/signup%20cubit/sign_up_cubit.dart';
import 'package:movie_app/auth/presentation/controller/signup%20cubit/sign_up_state.dart';
import 'package:movie_app/auth/presentation/widgets/sign_up_form_widget.dart';
import 'package:movie_app/movies/presentation/screens/home_screen.dart';

class SignUpBodyWidget extends StatelessWidget {
  const SignUpBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
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
              Text(
                'Create New Account',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                  color: Color(0xffF6F4F4),
                ),
              ),
              SizedBox(height: 30.h),
              SignUpFormWidget(),

            ],
          ),
        ),
      ),
    );
  }
}
