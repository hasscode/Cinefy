import 'package:dartz/dartz.dart';
import 'package:movie_app/auth/domain/repository/auth_base_repository.dart';

import '../../../core/error handling/failures.dart';
import '../entities/user_entity.dart';

class CheckEmailVerificationUseCase{
  AuthBaseRepository authBaseRepository ;

  CheckEmailVerificationUseCase(this.authBaseRepository);
  Future<Either<Failures,bool>>call()async{
    return await authBaseRepository.checkVerification();
  }
}