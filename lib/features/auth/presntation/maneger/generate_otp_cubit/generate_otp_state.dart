part of 'generate_otp_cubit.dart';

@immutable
abstract class GenerateOtpState {}

class GenerateOtpInitial extends GenerateOtpState {}

class GenerateOtpLoading extends GenerateOtpState {}

class GenerateOtpSuccess extends GenerateOtpState {
  final GenerateOtp generateOtp;

  GenerateOtpSuccess({required this.generateOtp});
}

class GenerateOtpFailure extends GenerateOtpState {
  final String message;

  GenerateOtpFailure({required this.message});
}
