import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/auth_repo.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.authRepo) : super(ResetPasswordInitial());
  final AuthRepo authRepo;
  Future<void> resetPassword(
      {required String password, required Map<String, dynamic> data}) async {
    emit(ResetPasswordLoading());
    final res = await authRepo.resetPassword(password, data);
    res.fold((failure) {
      emit(ResetPasswordFailure(failure.errorMessage));
    }, (message) {
      emit(ResetPasswordSuccess(message));
    });
  }
}
