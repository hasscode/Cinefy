import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/auth/domain/usecase/login_usecase.dart';
import 'package:movie_app/auth/presentation/controller/login%20cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginInitial());
  LoginUseCase loginUseCase;

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final result = await loginUseCase.call(email, password);
    result.fold(
      (failure) => emit(LoginFailure(failure.errMessage)),
      (user) => emit(LoginSuccess(user)),
    );
  }
}
