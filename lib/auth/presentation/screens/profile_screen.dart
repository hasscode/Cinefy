import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/auth/presentation/controller/check%20logged%20cubit/check_logged_cubit.dart';
import 'package:movie_app/auth/presentation/controller/check%20logged%20cubit/check_logout_state.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/auth/presentation/widgets/profile_options_widget.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider(create:  (context)=> sL<CheckLoggedCubit>()..checkAuthStatus())
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Profile',style: GoogleFonts.poppins(fontSize: 20.sp,fontWeight: FontWeight.w600,color: Colors.white),),
          centerTitle: true,
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.starsBackgroundImageBlur),fit: BoxFit.cover)
            ),
            child: BlocBuilder<CheckLoggedCubit,CheckLoggedState>(builder:(context,state) {
              if (state is CheckLoggedAuthenticated){
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h,),
                      Container(
                        width: 150.w,
                        height: 150.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Color(0xffD10909),width: 1),
                            color: Colors.black
                        ),
                        child: Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.person,size: 70.sp,color: Colors.white54,))),
                      ),
                      Text(state.user.username,style: GoogleFonts.poppins(fontSize: 22.sp,fontWeight: FontWeight.w600,color: Colors.white),) ,
                      SizedBox(height: 10.h,),
                      Text(state.user.email,style: GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Colors.white),),
                      SizedBox(height: MediaQuery.sizeOf(context).height*.38.h,),
                      Padding(
                        padding: const EdgeInsets.all(3),
                        child: ProfileOptionsWidget(),
                      )
                    ],
                  ),
                );
              }
              else if(state is CheckLoggedUnauthenticated){
                return   Center(child: Text(state.message,style: GoogleFonts.poppins(fontSize: 22.sp,fontWeight: FontWeight.w600,color: Colors.red),)) ;

              }
              else if(state is CheckLoggedLoading){
                return Center(child: CircularProgressIndicator(color: Color(0xffD10909),));
              }
              return Center(child: Text('Profile'));
            }),
          ),
        ),
      ),
    );
  }
}
