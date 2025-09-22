import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:page_transition/page_transition.dart';

import '../controller/logout cubit/logout_cubit.dart';
import '../controller/logout cubit/logout_state.dart';
import '../screens/landing_page.dart';
class LogoutDialogWidget extends StatelessWidget {
  const LogoutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>sL<LogoutCubit>(),
      child: Builder(
        builder: (context) {
          return Dialog(

            child:Container(
              width: 40.w,
              height: 150.h,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(13.sp),
                  border: Border.all(color: Color(0xff8B0606),width: .2)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Are you sure?',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20.sp,color: Colors.white),),
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                            overlayColor: Color(0xff8B0606)
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        }, child:  Text('No',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 17.sp,color: Colors.white),),),

                      Spacer(),
                      BlocListener<LogoutCubit,LogoutState>(
                        listener: (context,state){
                          if(state is LogoutSuccess){
                            Navigator.pushAndRemoveUntil(context, PageTransition(
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 300),
                              child:LandingPage(),
                            ),
                              (route)=> false
                            );
                          }
                          else if(state is LogoutFailure){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xff9C231D),
                                content: Text("${state.errMessage} 😕"),
                              ),
                            );
                          }
                        },
                        child: TextButton(
                          style: TextButton.styleFrom(
                              overlayColor: Color(0xff8B0606)
                          ),
                          onPressed: (){
                            BlocProvider.of<LogoutCubit>(context).logout();
                          }, child:  Text('Yes',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 17.sp,color: Color(0xff8B0606)),),),
                      ),
                      Spacer(),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
