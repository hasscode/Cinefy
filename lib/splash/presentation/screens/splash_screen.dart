import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/auth/presentation/controller/login%20cubit/login_cubit.dart';
import 'package:movie_app/auth/presentation/controller/login%20cubit/login_state.dart';
import 'package:movie_app/auth/presentation/screens/landing_page.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/movies/presentation/screens/home_screen.dart';
import 'package:movie_app/splash/presentation/widgets/splash_body_widget.dart';

import '../../../auth/presentation/controller/check logged cubit/check_logged_cubit.dart';
import '../../../auth/presentation/controller/check logged cubit/check_logout_state.dart';
import '../../../core/services/services_locator.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
     BlocProvider.of<CheckLoggedCubit>(context).checkAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckLoggedCubit, CheckLoggedState>(
      listener: (context, state) {
        if (state is CheckLoggedAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (state is CheckLoggedUnauthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LandingPage()),
          );
        }
      },
      child: const Scaffold(
        backgroundColor: Colors.black,
        body: SplashBodyWidget(),
      ),
    );
  }
}
