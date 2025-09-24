import 'package:dartz/dartz.dart';
import 'package:movie_app/auth/domain/repository/auth_base_repository.dart';

import '../../../core/error handling/failures.dart';
import '../entities/user_entity.dart';

class SendEmailVerificationUseCase{
  AuthBaseRepository authBaseRepository ;

  SendEmailVerificationUseCase(this.authBaseRepository);
  Future<Either<Failures,Unit>>call()async{
    return await authBaseRepository.sendEmailVerification();
  }
}