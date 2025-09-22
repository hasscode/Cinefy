import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/auth/presentation/controller/check logged cubit/check_logged_cubit.dart';
import 'package:movie_app/auth/presentation/controller/check logged cubit/check_logout_state.dart';
import 'package:movie_app/auth/presentation/screens/landing_page.dart';
import 'package:movie_app/movies/presentation/screens/home_screen.dart';
import 'package:movie_app/splash/presentation/widgets/splash_body_widget.dart';
import '../../../auth/presentation/controller/internet connection checker cubit/internet_connection_cubit.dart';
import '../../../auth/presentation/controller/internet connection checker cubit/internet_connection_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _authChecked = false; // عشان ميعملش checkAuth أكتر من مرة

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      final internetState = context.read<InternetCubit>().state;

      if (internetState is ConnectionFounded) {
        _checkAuthOnce();
      }
    });
  }

  void _checkAuthOnce() {
    if (_authChecked) return;
    _authChecked = true;
    context.read<CheckLoggedCubit>().checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // ✅ Listen للنت
        BlocListener<InternetCubit, InternetConnectionState>(
          listener: (context, state) {
            if (state is ConnectionFounded) {
              _checkAuthOnce();
            }
          },
        ),

        // ✅ Listen للـ Auth check
        BlocListener<CheckLoggedCubit, CheckLoggedState>(
          listener: (context, state) {
            if (state is CheckLoggedAuthenticated) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false, // ❌ يمسح كل اللي فات
              );
            } else if (state is CheckLoggedUnauthenticated) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LandingPage()),
                    (route) => false,
              );
            }
          },
        ),
      ],
      child: const Scaffold(
        backgroundColor: Colors.black,
        body: SplashBodyWidget(),
      ),
    );
  }
}
