import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/auth/domain/usecase/logout_use_case.dart';
import 'package:movie_app/auth/presentation/controller/logout%20cubit/logout_state.dart';

class LogoutCubit extends Cubit<LogoutState>{
  LogoutCubit(this.logoutUseCase) :super(LogoutInitial());
LogoutUseCase logoutUseCase;
  Future<void> logout()async{
    emit(LogoutLoading());
    final result = await logoutUseCase.call();
    result.fold(
          (failure) => emit(LogoutFailure(failure.errMessage)),
          (unit) => emit(LogoutSuccess()),
    );

  }

}