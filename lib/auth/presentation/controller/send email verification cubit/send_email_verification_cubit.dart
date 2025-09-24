import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/auth/domain/usecase/send_email_verification_use_case.dart';
import 'package:movie_app/auth/presentation/controller/check%20email%20verification%20cubit/check_email_verification_state.dart';
import 'package:movie_app/auth/presentation/controller/send%20email%20verification%20cubit/send_email_verification_state.dart';

class SendEmailVerificationCubit extends Cubit<SendEmailVerificationState> {
  SendEmailVerificationCubit(this.sendEmailVerificationUseCase)
    : super(SendEmailVerificationInitial());
  SendEmailVerificationUseCase sendEmailVerificationUseCase;

  Future<void> sendEmailVerification() async {
    final result = await sendEmailVerificationUseCase.call();
    result.fold(
      (failure) => emit(SendEmailVerificationFailure(failure.errMessage)),
      (unit) => emit(SendEmailVerificationSuccess()),
    );
  }
}
