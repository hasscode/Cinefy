import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/auth/presentation/controller/login%20cubit/login_cubit.dart';
import 'package:movie_app/auth/presentation/controller/login%20cubit/login_state.dart';
import 'package:movie_app/auth/presentation/screens/reset_password_screen.dart';
import 'package:movie_app/auth/presentation/screens/sign_up_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/widgets/custom_button_widget.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../movies/presentation/screens/home_screen.dart';
import '../../domain/usecase/create_account_usecase.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void dispose() {
    super.dispose();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CustomTextFormField(
              textEditingController: emailController,
              obscureText: false,
              title: 'Email',
              hintText: 'Enter your email address',
            ),
          ),
          SizedBox(height: 34),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CustomTextFormField(
              textEditingController: passwordController,
              obscureText: true,
              title: 'Password',
              hintText: 'Enter your password',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop, // slideRight, slideLeft, scale, rotate...
                      duration: const Duration(milliseconds: 300),
                      child: ResetPasswordScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(overlayColor: Color(0xffF8F8F8)),
                child: Text(
                  'Forget Password?',
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffF8F8F8),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 34),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Color(0xff9C231D),
                      content: Text("${state.errMessage} 😕"),
                    ),
                  );
                } else if (state is LoginSuccess) {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade, // slideRight, slideLeft, scale, rotate...
                      duration: const Duration(milliseconds: 300),
                      child: HomeScreen(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return CircularProgressIndicator(color: Color(0xff9C231D));
                }
                return CustomButtonWidget(
                  title: 'Login',
                  width: double.infinity.w,
                  height: 50.h,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        BlocProvider.of<LoginCubit>(
                          context,
                        ).login(emailController.text, passwordController.text);
                      });
                    }
                  },
                  colorButton: Color(0xff9C231D),
                  colorText: Color(0xffF6F4F4),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Spacer(),
              Text(
                "Don't have an account?",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffF8F8F8),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop, // slideRight, slideLeft, scale, rotate...
                        duration: const Duration(milliseconds: 300),
                        child: SignUpScreen(),
                      ));

                },
                style: TextButton.styleFrom(overlayColor: Color(0xff9C231D)),
                child: Text(
                  'Create one now',
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff9C231D),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
