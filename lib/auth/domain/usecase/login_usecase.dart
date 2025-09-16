import 'package:dartz/dartz.dart';
import 'package:movie_app/auth/domain/repository/auth_base_repository.dart';

import '../../../core/error handling/failures.dart';
import '../entities/user_entity.dart';

class LoginUseCase{
  AuthBaseRepository authBaseRepository ;

  LoginUseCase(this.authBaseRepository);
  Future<Either<Failures,UserEntity>>call(String email,String password)async{
    return await authBaseRepository.login(email, password);
  }
}