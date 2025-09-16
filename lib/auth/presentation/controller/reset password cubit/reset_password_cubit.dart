import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/auth/domain/usecase/reset_password_use_case.dart';
import 'package:movie_app/auth/presentation/controller/reset%20password%20cubit/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState>{
  ResetPasswordCubit(this.resetPasswordUseCase) : super(ResetPasswordInitial());
  ResetPasswordUseCase resetPasswordUseCase;
  Future<void>resetPassword(String email)async{
    emit(ResetPasswordLoading());
    final result =await resetPasswordUseCase.call(email);
    result.fold((failure)=>emit(ResetPasswordFailure(failure.errMessage)), (unit)=>emit(ResetPasswordSuccess()));
  }
}