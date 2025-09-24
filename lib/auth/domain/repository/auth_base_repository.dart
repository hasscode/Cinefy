import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error%20handling/failures.dart';

import '../entities/user_entity.dart';

abstract class AuthBaseRepository {
   Future<Either<Failures,UserEntity>>login(String email ,String password);
   Future<Either<Failures,UserEntity>>createAccount(String email ,String password,String username);
   Future<Either<Failures,Unit>>resetPassword(String email );
   Future<Either<Failures,UserEntity>>checkLogged();
   Future<Either<Failures,Unit>>logout();
   Future<Either<Failures,Unit>>sendEmailVerification();
   Future<Either<Failures,Unit>>deleteAccount();
   Future<Either<Failures,bool>>checkVerification();

}
// Future<Either<User ,Failures>>