import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/check_logged_use_case.dart';
import 'check_logout_state.dart';


class CheckLoggedCubit extends Cubit<CheckLoggedState> {
  CheckLoggedCubit(this.checkLoggedUseCase) : super(CheckLoggedInitial());

  final CheckLoggedUseCase checkLoggedUseCase;

  Future<void> checkAuthStatus() async {
    emit(CheckLoggedLoading());

    final result = await checkLoggedUseCase();

    result.fold(
          (failure) => emit(CheckLoggedUnauthenticated(failure.errMessage)),
          (user) => emit(CheckLoggedAuthenticated(user)),
    );
  }
}