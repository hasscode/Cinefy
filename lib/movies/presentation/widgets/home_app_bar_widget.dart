import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/auth/presentation/screens/profile_screen.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/search/presentation/screens/search_screen.dart';
import 'package:page_transition/page_transition.dart';
class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: (){
             Navigator.push(context,  PageTransition(
               type: PageTransitionType.leftToRight, // slideRight, slideLeft, scale, rotate...
               duration: const Duration(milliseconds: 300),
               child: const ProfileScreen(),
             ),);
          },
          child: Container(

            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
border: Border.all(color: Color(0xffD10909),width: .7),
              borderRadius: BorderRadius.circular(50)
              ,color: Colors.black54,

            ),
            child: Center(
                child: Icon(Icons.person,size: 28.sp,color: Colors.white70,)
            ),
          ),
        ),
        Spacer(),
        // Image.asset(AppImages.logoImage,width: 50,),
        // Spacer(),
       Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.hardLight,
              borderRadius: BorderRadius.circular(50)
              ,color: Colors.grey,

            ),
            child: Center(
                child: IconButton(onPressed: (){
                  Navigator.push(context,  PageTransition(
                    type: PageTransitionType.bottomToTop, // slideRight, slideLeft, scale, rotate...
                    duration: const Duration(milliseconds: 300),
                    child: const SearchScreen(),
                  ),);
                }, icon: Icon(CupertinoIcons.search,size: 27.sp,color: Colors.white70,))
            ),
          ),

      ],
    );
  }
}
