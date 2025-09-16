import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/styles/app_images.dart';
import 'package:movie_app/core/utils/constants.dart';
import 'package:movie_app/movies/domain/entities/credit.dart';
class CastDetailsItemWidget extends StatelessWidget {
  const CastDetailsItemWidget({super.key,required this.credit});
final Credit credit ;
  @override
  Widget build(BuildContext context) {
    return Column(children: [

          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              border: Border.all(width: .8, color: Color(0xffD10909)),
                borderRadius:BorderRadius.circular(30.sp),
                image: DecorationImage( image:credit.profileImage!=null? CachedNetworkImageProvider(Constants.imageUrl(credit.profileImage!)):AssetImage(AppImages.personImage),fit: BoxFit.cover)
            ),

          ),
          SizedBox( height: 5.h,),
          Text(credit.originalName,style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12.5.sp,color: Color(0xffB6B6BA),),
          ),
          SizedBox( height: 5.h,),
          Text(credit.character,style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 9.5.sp,color: Color(0xffB8B8B8),),
          ),
        ],);
  }
}
