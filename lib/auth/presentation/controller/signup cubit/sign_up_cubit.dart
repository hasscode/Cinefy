import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/auth/domain/usecase/create_account_usecase.dart';
import 'package:movie_app/auth/presentation/controller/signup%20cubit/sign_up_state.dart';

import '../../../../core/error handling/failures.dart';
import '../../../domain/entities/user_entity.dart';

class SignUpCubit extends Cubit<SignUpState>{
  CreateAccountUseCase createAccountUseCase ;
  SignUpCubit(this.createAccountUseCase) : super (SignUpInitial());

  Future<void> createAccount(String email, String password,String username) async{
  emit(SignUpLoading());
    final result = await createAccountUseCase.call(email, password,username);
    result.fold((failure)=>emit(SignUpFailure(failure.errMessage)), (user)=>emit(SignUpSuccess(user)));

  }
}