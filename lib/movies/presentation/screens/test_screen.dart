import 'package:flutter/material.dart';
import 'package:movie_app/auth/presentation/screens/landing_page.dart';
import 'package:movie_app/auth/presentation/screens/sign_up_screen.dart';
import 'package:movie_app/movies/presentation/screens/home_screen.dart';
import 'package:movie_app/splash/presentation/screens/splash_screen.dart';
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()));

        }, child: Text('Go')),
      ),
    );
  }
}
