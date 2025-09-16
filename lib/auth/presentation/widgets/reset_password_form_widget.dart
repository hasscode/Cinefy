import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/auth/presentation/controller/reset%20password%20cubit/reset_password_cubit.dart';
import 'package:movie_app/auth/presentation/screens/check_your_email_screen.dart';
import 'package:movie_app/auth/presentation/screens/login_screen.dart';

import '../../../core/widgets/custom_button_widget.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../controller/reset password cubit/reset_password_state.dart';
class ResetPasswordFormWidget extends StatefulWidget {
  const ResetPasswordFormWidget({super.key});

  @override
  State<ResetPasswordFormWidget> createState() => _ResetPasswordFormWidgetState();
}

class _ResetPasswordFormWidgetState extends State<ResetPasswordFormWidget> {

  final TextEditingController emailController = TextEditingController();


  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void dispose() {
    super.dispose();
    emailController.clear();
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) {
                if (state is ResetPasswordFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Color(0xff9C231D),
                      content: Text("${state.errMessage} 😕"),
                    ),
                  );
                } else if (state is ResetPasswordSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckYourEmailScreen()),
                  );
                }
              },
              builder: (context, state) {
                if (state is ResetPasswordLoading) {
                  return CircularProgressIndicator(color: Color(0xff9C231D));
                }
                return CustomButtonWidget(
                  title: 'Send Email',
                  width: double.infinity.w,
                  height: 50.h,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        BlocProvider.of<ResetPasswordCubit>(
                          context,
                        ).resetPassword(emailController.text);
                      });
                    }
                  },
                  colorButton: Color(0xff9C231D),
                  colorText: Color(0xffF6F4F4),
                );
              },
            ),
          ),
          SizedBox(height: 34.h,)
        ],
      ),
    );
  }
}
