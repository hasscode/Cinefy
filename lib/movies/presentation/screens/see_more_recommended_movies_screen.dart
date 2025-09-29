// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:movie_app/movies/domain/entities/movie.dart';
//
// import '../../../core/widgets/movie_info_item_widget.dart';
// class SeeMoreRecommendedMoviesScreen extends StatelessWidget {
//   const SeeMoreRecommendedMoviesScreen({super.key,required this.recommendedMovies});
// final List<Movie> recommendedMovies;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  AppBar(
//         elevation: 0,
//         backgroundColor: Colors.black,
//         title: Text(
//           'Recommendations',
//           style: GoogleFonts.poppins(
//             fontSize: 17.5.sp,
//             fontWeight: FontWeight.bold,
//             color: const Color(0xffBFBFBF),
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_outlined,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body:  SliverList(
//         delegate: SliverChildBuilderDelegate(
//               (context, i) => Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 5,
//               vertical: 8,
//             ),
//             child: MovieInfoItemWidget(
//               movie: state.popularMovies[i],
//             ),
//           ),
//           childCount: state.popularMovies.length,
//         ),
//       ),
//
//     );
//   }
// }
