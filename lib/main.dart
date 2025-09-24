import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/auth/presentation/controller/delete%20account%20cubit/delete_account_cubit.dart';
import 'package:movie_app/movies/presentation/controller/favourit%20cubit/Favorites_cubit.dart';
import 'package:movie_app/splash/presentation/screens/no_connection_screen.dart';
import 'package:movie_app/splash/presentation/screens/splash_screen.dart';
import 'auth/presentation/controller/check email verification cubit/check_email_verification_cubit.dart';
import 'auth/presentation/controller/check logged cubit/check_logged_cubit.dart';
import 'auth/presentation/controller/internet connection checker cubit/internet_connection_cubit.dart';
import 'auth/presentation/controller/internet connection checker cubit/internet_connection_state.dart';
import 'auth/presentation/controller/send email verification cubit/send_email_verification_cubit.dart';
import 'core/services/services_locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ServiceLocator().init();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

      designSize: const Size(390, 844),
      minTextAdapt: true,
        splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sL<InternetCubit>()),
          BlocProvider(create: (_) => CheckLoggedCubit(sL())),
          BlocProvider(create: (context) => sL<CheckEmailVerificationCubit>()),
          BlocProvider(create: (context) => sL<SendEmailVerificationCubit>()),
          BlocProvider(create: (context) => sL<DeleteAccountCubit>()),
          BlocProvider(create: (context) => sL<FavoritesCubit>()),

        ],
        child:BlocListener<InternetCubit, InternetConnectionState>(
          listener: (context, state) {
            if (state is NoConnection) {
              showGeneralDialog(
                context: navigatorKey.currentState!.overlay!.context,
                barrierDismissible: false,
                barrierLabel: "NoConnection",
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (context, animation, secondaryAnimation) =>
                const NoConnectionScreen(),
                transitionBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            } else if (state is ConnectionFounded) {
              if (navigatorKey.currentState!.canPop()) {
                navigatorKey.currentState!.pop();
              }
            }
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
