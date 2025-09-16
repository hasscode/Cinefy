import 'package:dartz/dartz.dart';
import 'package:movie_app/auth/domain/repository/auth_base_repository.dart';

import '../../../core/error handling/failures.dart';
import '../entities/user_entity.dart';

class CreateAccountUseCase{
  AuthBaseRepository authBaseRepository ;

  CreateAccountUseCase(this.authBaseRepository);
  Future<Either<Failures,UserEntity>>call(String email,String password,String username)async{
    return await authBaseRepository.createAccount(email, password,username);
  }
}