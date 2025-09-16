import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/splash/presentation/screens/splash_screen.dart';

import 'auth/presentation/controller/check logged cubit/check_logged_cubit.dart';
import 'core/services/services_locator.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ServiceLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(365, 790),
      minTextAdapt: true,
      child: BlocProvider(
        create: (_) => CheckLoggedCubit(sL()),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
