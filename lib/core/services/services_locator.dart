import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/auth/data/data_source/auth_remote_data_source.dart';
import 'package:movie_app/auth/domain/repository/auth_base_repository.dart';
import 'package:movie_app/auth/domain/usecase/check_logged_use_case.dart';
import 'package:movie_app/auth/domain/usecase/create_account_usecase.dart';
import 'package:movie_app/auth/domain/usecase/login_usecase.dart';
import 'package:movie_app/auth/domain/usecase/logout_use_case.dart';
import 'package:movie_app/auth/presentation/controller/check%20logged%20cubit/check_logged_cubit.dart';
import 'package:movie_app/auth/presentation/controller/login%20cubit/login_cubit.dart';
import 'package:movie_app/auth/presentation/controller/reset%20password%20cubit/reset_password_cubit.dart';
import 'package:movie_app/auth/presentation/controller/signup%20cubit/sign_up_cubit.dart';
import 'package:movie_app/movies/data/data_source/movies_remote_data_source.dart';
import 'package:movie_app/movies/data/repositories/movies_repository.dart';
import 'package:movie_app/movies/domain/usecase/get_credits_use_case.dart';
import 'package:movie_app/movies/domain/usecase/get_movie_details.dart';
import 'package:movie_app/movies/domain/usecase/get_movie_player_use_case.dart';
import 'package:movie_app/movies/domain/usecase/get_movie_recommendation_usecase.dart';
import 'package:movie_app/movies/domain/usecase/get_play_now_usecase.dart';
import 'package:movie_app/movies/domain/usecase/get_popular_usecase.dart';
import 'package:movie_app/movies/domain/usecase/get_top_rated_usecase.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc/movie_details_bloc.dart';
import 'package:movie_app/search/data/data_source/search_remote_data_source.dart';
import 'package:movie_app/search/data/repositories/search_repository_impl.dart';
import 'package:movie_app/search/domain/repositories/search_repository.dart';
import 'package:movie_app/search/domain/usecase/get_movie_by_search_use_case.dart';

import '../../auth/data/repository/auth_repository.dart';
import '../../auth/domain/usecase/reset_password_use_case.dart';
import '../../auth/presentation/controller/internet connection checker cubit/internet_connection_cubit.dart';
import '../../auth/presentation/controller/logout cubit/logout_cubit.dart';

import '../../movies/domain/repositories/base_movies_repository.dart';
import '../../movies/presentation/controller/movies_bloc/movies_bloc.dart';
import '../../search/presentation/controller/search cubit/search_cubit.dart';

final sL = GetIt.instance;
class ServiceLocator {
  init() {
    ///bloc
sL.registerFactory(()=>MoviesBloc(
  sL<GetPlayNowUseCase>(),
  sL<GetPopularUsecase>(),
  sL<GetTopRatedUseCase>(),
));
sL.registerFactory(()=>SignUpCubit(sL<CreateAccountUseCase>()));
sL.registerFactory(()=>MovieDetailsBloc(sL<GetMovieDetailsUseCase>(),
  sL<GetMovieRecommendationUseCase>(),
  sL<GetCreditsUseCase>(),
  sL<GetMoviePlayerUseCase>(),
));
sL.registerFactory(()=>LoginCubit(sL<LoginUseCase>()));
sL.registerFactory(()=>ResetPasswordCubit(sL<ResetPasswordUseCase>()));
sL.registerFactory(()=>CheckLoggedCubit(sL<CheckLoggedUseCase>()));
sL.registerFactory(()=>LogoutCubit(sL<LogoutUseCase>()));
sL.registerFactory(()=>SearchCubit(sL<GetMoviesBySearchUseCase>()));
sL.registerFactory(()=>InternetCubit(sL<Connectivity>()));

    /// UseCase
    sL.registerLazySingleton<GetPlayNowUseCase>(() => GetPlayNowUseCase(sL()));
    sL.registerLazySingleton<GetPopularUsecase>(() => GetPopularUsecase(sL()));
    sL.registerLazySingleton<GetTopRatedUseCase>(() => GetTopRatedUseCase(sL()));
    sL.registerLazySingleton<GetMovieRecommendationUseCase>(() => GetMovieRecommendationUseCase(sL()));
    sL.registerLazySingleton<GetMovieDetailsUseCase>(() => GetMovieDetailsUseCase(sL()));
    sL.registerLazySingleton(()=>CreateAccountUseCase(sL()));
    sL.registerLazySingleton(()=>LoginUseCase(sL()));
    sL.registerLazySingleton(()=>ResetPasswordUseCase(sL()));
    sL.registerLazySingleton<CheckLoggedUseCase>(()=>CheckLoggedUseCase(sL()));
    sL.registerLazySingleton<LogoutUseCase>(()=>LogoutUseCase(sL()));
    sL.registerLazySingleton<GetCreditsUseCase>(()=>GetCreditsUseCase(sL()));
    sL.registerLazySingleton<GetMoviePlayerUseCase>(()=>GetMoviePlayerUseCase(sL()));
    sL.registerLazySingleton<GetMoviesBySearchUseCase>(()=>GetMoviesBySearchUseCase(sL<SearchRepository>()));


    /// Repository
    sL.registerLazySingleton<BaseMoviesRepository>(() =>
        MoviesRepository(sL()));
     sL.registerLazySingleton<AuthBaseRepository>(()=>AuthRepository(sL()));
     sL.registerLazySingleton<SearchRepository>(()=>SearchRepositoryImpl(sL()));

    /// Data Source
    sL.registerLazySingleton<MovieBaseRemoteDataSource>(() =>
        MovieRemoteDataSource(sL()));
sL.registerLazySingleton<SearchRemoteDataSource>(() =>
    SearchRemoteDataSourceImpl(sL()));
sL.registerLazySingleton<AuthBaseDataSource>(()=>AuthDataSource(sL()));


/// firebase Auth

sL.registerLazySingleton<FirebaseAuth>(()=> FirebaseAuth.instance);

    /// Dio
    sL.registerLazySingleton(() => Dio());

    /// connectivity

    sL.registerLazySingleton(() => Connectivity());
  }
}