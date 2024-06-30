import 'package:dartz/dartz.dart';
import 'package:kemet/features/auth/data/models/ConfirmEmailModel.dart';
import 'package:kemet/features/auth/data/models/generate_otp.dart';

import '../../../../core/errors/failure.dart';
import '../models/auth_model.dart';

abstract class AuthRepo {
  Future<Either<Failures, AuthModel>> login(String email, String password);

  Future<Either<Failures, AuthModel>> register(
    String email,
    String password,
    String confirmPassword,
    String phone,
    String firstName,
    String lastName,
    int age,
    String gender,
  );

  Future<Either<Failures, GenerateOtp>> generateOtp(String email);

  Future<Either<Failures, ConfirmEmailModel>> confirmEmailByOtp(
      String id, int otp, bool isRegister);

  Future<Either<Failures, String>> resetPassword(
      String password, Map<String, dynamic> data);
}
