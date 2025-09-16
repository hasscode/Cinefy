import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/auth/presentation/controller/signup%20cubit/sign_up_cubit.dart';
import 'package:movie_app/auth/presentation/widgets/sign_up_body_widget.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/styles/app_images.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SignUpCubit(sL()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.starsBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  FadeIn(child: Image.asset(AppImages.logoImage, width: 200.w)),
                  SizedBox(height: 30.h),
                  SignUpBodyWidget(),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
