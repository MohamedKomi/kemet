import 'package:bloc/bloc.dart';
import 'package:kemet/features/auth/data/repositories/auth_repo.dart';

import 'confirm_email_otp_state.dart';


class ConfirmEmailByOTPCubit extends Cubit<ConfirmEmailByOTPState> {
  ConfirmEmailByOTPCubit(this.authRepo) : super(ConfirmEmailInitial());
  final AuthRepo authRepo;
  Future<void> verifyOtp({required String id,required int otp,required bool isRegister}) async {
    emit(ConfirmEmailLoading());
    final res = await authRepo.confirmEmailByOtp(id,otp,isRegister);
    res.fold((failure) {

      emit(ConfirmEmailFailure(failure.errorMessage));
    }, (otp) {
      emit(ConfirmEmailSuccess(otp));
    });
  }
}
