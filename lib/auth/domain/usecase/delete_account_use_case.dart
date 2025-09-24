import 'package:dartz/dartz.dart';

import '../../../core/error handling/failures.dart';
import '../repository/auth_base_repository.dart';

class DeleteAccountUseCase{
  AuthBaseRepository authBaseRepository ;
  DeleteAccountUseCase(this.authBaseRepository);
  Future<Either<Failures,Unit>>call()async{
    return await authBaseRepository.deleteAccount();
  }


}