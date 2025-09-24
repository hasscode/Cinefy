import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/auth/domain/usecase/delete_account_use_case.dart';
import 'package:movie_app/auth/presentation/controller/delete%20account%20cubit/delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountUseCase deleteAccountUseCase;
  DeleteAccountCubit(this.deleteAccountUseCase) : super(DeleteAccountLoading());

  Future<void> deleteAccount() async {
    final result = await deleteAccountUseCase.call();
    result.fold(
      (failure) => emit(DeleteAccountFailure(failure.errMessage)),
      (unit) => emit(DeleteAccountSuccess()),
    );
  }
}
