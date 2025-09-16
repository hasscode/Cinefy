import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/auth/presentation/screens/profile_screen.dart';
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

            height: 45.h,
            width: 45.w,
            decoration: BoxDecoration(
border: Border.all(color: Color(0xffD10909),width: .7),
              borderRadius: BorderRadius.circular(50)
              ,color: Colors.black54,

            ),
            child: Center(
                child: Icon(Icons.person,size: 25.sp,color: Colors.white70,)
            ),
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SizedBox.shrink()));
          },
          child: Container(

            height: 45.h,
            width: 45.w,
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.hardLight,
              borderRadius: BorderRadius.circular(50)
              ,color: Colors.grey,

            ),
            child: Center(
                child: Icon(CupertinoIcons.search,size: 25.sp,color: Colors.white70,)
            ),
          ),
        ),
      ],
    );
  }
}
