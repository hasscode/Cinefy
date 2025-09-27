import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/auth/presentation/screens/login_screen.dart';
import 'package:movie_app/auth/presentation/screens/verify_your_email_screen.dart';
import 'package:movie_app/core/widgets/custom_button_widget.dart';
import 'package:page_transition/page_transition.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../movies/presentation/screens/home_screen.dart';
import '../controller/signup cubit/sign_up_cubit.dart';
import '../controller/signup cubit/sign_up_state.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({super.key});

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool obscurePassword = true;
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void dispose() {
    super.dispose();
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
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
              textEditingController: usernameController,
              obscureText: false,
              title: 'Username',
              hintText: 'Enter your username',
            ),
          ),
          SizedBox(height: 34),
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
              isPassword: true,
              onTogglePassword: (){
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
            ),
          ),
          SizedBox(height: 34),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Color(0xff9C231D),
                      content: Text("${state.errMessage} 😕"),
                    ),
                  );
                } else if (state is SignUpSuccess) {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade, // slideRight, slideLeft, scale, rotate...
                      duration: const Duration(milliseconds: 300),
                      child: VerifyYourEmailScreen(),
                    ),

                  );
                }
              },
              builder:(context,state) {
              if(state is SignUpLoading){
                return CircularProgressIndicator(color: Colors.white,);
              }
              return   CustomButtonWidget(
                title: 'Create Account',
                width: double.infinity.w,
                height: 50.h,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      BlocProvider.of<SignUpCubit>(context).createAccount(
                        emailController.text.trim(),
                        passwordController.text,
                        usernameController.text.trim()
                      );
                    });
                  }
                },
                colorButton: Color(0xffF6F4F4),
                colorText: Color(0xff9C231D),
              );
              }
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Spacer(),
              Text(
                'Already have an account ?',
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
                      child: LoginScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(overlayColor: Color(0xff9C231D)),
                child: Text(
                  'Login',
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
