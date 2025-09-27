import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/auth/presentation/controller/check%20email%20verification%20cubit/check_email_verification_cubit.dart';
import 'package:movie_app/auth/presentation/controller/check%20email%20verification%20cubit/check_email_verification_state.dart';
import 'package:movie_app/auth/presentation/controller/delete%20account%20cubit/delete_account_cubit.dart';
import 'package:movie_app/auth/presentation/controller/logout%20cubit/logout_cubit.dart';
import 'package:movie_app/auth/presentation/controller/send%20email%20verification%20cubit/send_email_verification_cubit.dart';
import 'package:movie_app/auth/presentation/controller/send%20email%20verification%20cubit/send_email_verification_state.dart';
import 'package:movie_app/auth/presentation/screens/login_screen.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/core/widgets/custom_button_widget.dart';
import 'package:page_transition/page_transition.dart';

import 'landing_page.dart';

class VerifyYourEmailScreen extends StatefulWidget {
  const VerifyYourEmailScreen({super.key});

  @override
  State<VerifyYourEmailScreen> createState() => _VerifyYourEmailScreenState();
}

class _VerifyYourEmailScreenState extends State<VerifyYourEmailScreen>
    with WidgetsBindingObserver {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

      context.read<CheckEmailVerificationCubit>().resetState();
      context.read<CheckEmailVerificationCubit>().startChecking();

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if (state == AppLifecycleState.resumed) {
      context.read<CheckEmailVerificationCubit>().checkVerification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.starsBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 70.h),
            Image.asset(AppImages.logoImage, width: 250.w),
            SizedBox(height: 70.h),


            BlocBuilder<CheckEmailVerificationCubit,
                CheckEmailVerificationState>(
              builder: (context, state) {
                if (state is EmailVerified) {
                  return Column(
                    children: [
                      Text(
                        'Your Email has been Verified ✅',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp),
                      ),
                      SizedBox(height: 70.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CustomButtonWidget(
                          title: 'Login Now',
                          width: double.infinity,
                          height: 50.h,
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                PageTransition(
                                    type: PageTransitionType.bottomToTop,
                                    child: LoginScreen()),
                                    (route) => false);
                          },
                          colorButton: Color(0xffD10909),
                          colorText: Colors.white,
                        ),
                      )
                    ],
                  );
                } else if (state is EmailNotVerified) {
                  return Column(
                    children: [

                      Text(
                        'The verification has been sent',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Check your Email now',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp),
                      ),
                      SizedBox(height: 70.h),
                      BlocListener<SendEmailVerificationCubit,
                          SendEmailVerificationState>(
                        listener: (context, state) {
                          if (state is SendEmailVerificationSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Verification Email Is Resent',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white),
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else if (state
                          is SendEmailVerificationFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Error , Please try Again Later 😕',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: BlocBuilder<SendEmailVerificationCubit,
                            SendEmailVerificationState>(
                          builder: (context, state) {
                            if (state is SendEmailVerificationLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffD10909),
                                ),
                              );
                            }
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                              child: CustomButtonWidget(
                                title: 'Resend email verification',
                                width: double.infinity,
                                height: 50.h,
                                onTap: () {
                                  BlocProvider.of<
                                      SendEmailVerificationCubit>(
                                      context)
                                      .sendEmailVerification();
                                },
                                colorButton: Color(0xffD10909),
                                colorText: Colors.white,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
                } else if (state is FailureState) {
                  return Text(
                    state.errMessage,
                    style: TextStyle(color: Colors.red),
                  );
                } else if (state is LoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
                return Column(
                  children: [
                    Text(
                      'The verification has been sent',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Check your Email now',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomButtonWidget(
                title: 'cancel',
                width: double.infinity,
                height: 50.h,
                onTap: (){

                  context.read<CheckEmailVerificationCubit>().stopChecking();

            context.read<DeleteAccountCubit>().deleteAccount();
            Navigator.pushAndRemoveUntil(
            context,
            PageTransition(type: PageTransitionType.fade, child: const LandingPage()),
            (route) => false,
            );
            },
                colorButton: Colors.white,
                colorText: Color(0xffD10909),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
