import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/utils/enums/request_state_enum.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc/movie_details_bloc.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc/movie_details_events.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc/movie_details_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WatchMovieScreen extends StatefulWidget {
  const WatchMovieScreen({
    super.key,
    required this.movieID,
    required this.movieTitle,
  });

  final String movieTitle;
  final int movieID;

  @override
  State<WatchMovieScreen> createState() => _WatchMovieScreenState();
}

class _WatchMovieScreenState extends State<WatchMovieScreen> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      sL<MovieDetailsBloc>()..add(GetMoviePlayer(widget.movieID)),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            widget.movieTitle,
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
        body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state.moviePlayerState == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.moviePlayerState == RequestState.error) {
              return Center(
                child: Text(state.moviePlayerMessage),
              );
            } else if (state.moviePlayerState == RequestState.success) {
              final movieUrl = state.moviePlayer;

              controller = WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setBackgroundColor(Colors.black)
                ..setNavigationDelegate(NavigationDelegate())
                ..loadRequest(Uri.parse(movieUrl));

              return WebViewWidget(controller: controller!);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
