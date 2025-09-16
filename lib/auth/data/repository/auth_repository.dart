import 'package:dartz/dartz.dart';
import 'package:movie_app/auth/data/data_source/auth_remote_data_source.dart';
import 'package:movie_app/auth/domain/entities/user_entity.dart';
import 'package:movie_app/auth/domain/repository/auth_base_repository.dart';
import 'package:movie_app/core/error%20handling/failures.dart';

class AuthRepository extends AuthBaseRepository{
  AuthBaseDataSource authBaseDataSource ;
  AuthRepository(this.authBaseDataSource);
  @override
  Future<Either<Failures,UserEntity >> createAccount(String email, String password,String username) async{
 final result = await authBaseDataSource.createAccount(email, password,username);
    return result;
  }

  @override
  Future<Either<Failures,UserEntity>> login(String email, String password) async{
   return await authBaseDataSource.login(email, password);
  }

  @override
  Future<Either<Failures, Unit>> resetPassword(String email) async{
  return await authBaseDataSource.resetPassword(email);
  }




  @override
  Future<Either<Failures, UserEntity>> checkLogged() async{
return await authBaseDataSource.checkLogged();
  }

  @override
  Future<Either<Failures, Unit>> logout() async{
   return await authBaseDataSource.logout();
  }
}