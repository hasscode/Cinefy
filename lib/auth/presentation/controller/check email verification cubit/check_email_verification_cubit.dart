import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/auth/domain/usecase/check_email_verification_use_case.dart';
import 'package:movie_app/auth/presentation/controller/check%20email%20verification%20cubit/check_email_verification_state.dart';

class CheckEmailVerificationCubit extends Cubit<CheckEmailVerificationState> {
  final CheckEmailVerificationUseCase checkEmailVerificationUseCase;
  Timer? _timer;

  CheckEmailVerificationCubit(this.checkEmailVerificationUseCase)
      : super(InitialState());

  void resetState() {
    emit(InitialState());
  }

  void startChecking() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      checkVerification();
    });
  }


  Future<void> checkVerification() async {
    emit(LoadingState());
    final result = await checkEmailVerificationUseCase.call();
    result.fold(
          (failure) => emit(FailureState(failure.errMessage)),
          (isVerified) {
        if (isVerified) {
          emit(EmailVerified());
          stopChecking(); // بمجرد ما يتأكد إنه اتفعل نوقف التايمر
        } else {
          emit(EmailNotVerified());
        }
      },
    );
  }


  void stopChecking() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    stopChecking();
    return super.close();
  }
}
