import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/auth/presentation/controller/logout%20cubit/logout_cubit.dart';
import 'package:movie_app/auth/presentation/controller/logout%20cubit/logout_state.dart';
import 'package:movie_app/auth/presentation/screens/landing_page.dart';
import 'package:movie_app/auth/presentation/widgets/logout_dialog_widget.dart';
import 'package:movie_app/movies/presentation/widgets/favorite_movies_screen.dart';
import 'package:page_transition/page_transition.dart';
class ProfileOptionsWidget extends StatelessWidget {
  const ProfileOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 2,
          color: Colors.transparent,
          shadowColor: Colors.white30,
          child: ListTile(
            leading: Icon(Icons.favorite_sharp,color: Color(0xffD10909),size: 22,),
            title: Text('Favorites',style: GoogleFonts.poppins(fontSize: 17.sp,fontWeight: FontWeight.w400,color: Colors.white),),
            trailing: IconButton(onPressed: (){
              Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 300),child: FavoriteMoviesScreen()),);
            }, icon: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,size: 22,)),
          ),
        ),
        Card(
          elevation: 2,
          color: Colors.transparent,
          shadowColor: Colors.white30,
          child: ListTile(
            leading: Icon(Icons.lock,color: Colors.white,size: 22,),
            title: Text('Change Password',style: GoogleFonts.poppins(fontSize: 17.sp,fontWeight: FontWeight.w400,color: Colors.white),),
            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,size: 22,)),
          ),
        ),

      Card(
            elevation: 2,
            color: Colors.transparent,
            shadowColor: Colors.white30,
            child: ListTile(
              leading: Icon(Icons.logout,color: Colors.white,size: 22,),
              title: Text('Logout',style: GoogleFonts.poppins(fontSize: 17.sp,fontWeight: FontWeight.w400,color: Colors.white),),
              trailing: IconButton(onPressed: (){
                showDialog(context: context, builder: (context)=> LogoutDialogWidget());

              }, icon: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,size: 22,)),
            ),
          ),

        SizedBox(height: 10,)

      ],
    );
  }
}
