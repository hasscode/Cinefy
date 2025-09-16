import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/auth/presentation/controller/reset%20password%20cubit/reset_password_cubit.dart';
import 'package:movie_app/auth/presentation/widgets/reset_password_body_widget.dart';
import 'package:movie_app/core/styles/app_images.dart';

import '../../../core/services/services_locator.dart';
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ResetPasswordCubit(sL()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.starsBackgroundImage),fit: BoxFit.cover)
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  FadeIn(child: Image.asset(AppImages.logoImage, width: 200.w)),
                  SizedBox(height: 30.h),
                 ResetPasswordBodyWidget(),
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
