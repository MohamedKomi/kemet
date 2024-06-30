import 'package:bloc/bloc.dart';
import 'package:kemet/features/auth/data/models/generate_otp.dart';
import 'package:kemet/features/auth/data/repositories/auth_repo.dart';
import 'package:meta/meta.dart';

part 'generate_otp_state.dart';

class GenerateOtpCubit extends Cubit<GenerateOtpState> {
  GenerateOtpCubit(this.authRepo) : super(GenerateOtpInitial());
  final AuthRepo authRepo;
  int? otp;

  Future<void> generateOtp({required String email}) async {
    emit(GenerateOtpLoading());
    final res = await authRepo.generateOtp(email);
    res.fold((failure) {

      emit(GenerateOtpFailure(message: failure.errorMessage));
    }, (otp) {
      emit(GenerateOtpSuccess(generateOtp: otp));
    });
  }
}
