import 'package:dartz/dartz.dart';

import '../../../core/error handling/failures.dart';
import '../repository/auth_base_repository.dart';

class ResetPasswordUseCase{
  AuthBaseRepository authBaseRepository ;
  ResetPasswordUseCase(this.authBaseRepository);
  Future<Either<Failures,Unit>>call(String email)async{
    return await authBaseRepository.resetPassword(email);
  }


}