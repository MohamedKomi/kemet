import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kemet/core/errors/failure.dart';
import 'package:kemet/features/auth/data/models/auth_model.dart';
import 'package:kemet/features/auth/data/models/generate_otp.dart';
import 'package:kemet/features/auth/data/repositories/auth_repo.dart';

import '../../../../core/utils/api_service.dart';
import '../models/ConfirmEmailModel.dart';

class AuthRepoImplementation extends AuthRepo {
  final ApiService apiService;

  AuthRepoImplementation(this.apiService);

  @override
  Future<Either<Failures, AuthModel>> login(
      String email, String password) async {
    try {
      final Map<String, dynamic> data = {'email': email, 'password': password};
      final res =
          await apiService.postData(endPoint: 'auth/signin', data: data);

      if (res['message'] == 'success') {
        return right(AuthModel.fromJson(res));
      } else {
        return left(
          ServerFailure(res['message']),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, AuthModel>> register(
      String email,
      String password,
      String confirmPassword,
      String phone,
      String firstName,
      String lastName,
      int age,
      String gender) async {
    try {
      final Map<String, dynamic> data = {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'repassword': confirmPassword,
        'age': age,
        'gender': gender,
        'phone': phone
      };

      final res =
          await apiService.postData(endPoint: 'auth/signup', data: data);

      if (res['message'] == 'success') {
        return right(AuthModel.fromJson(res));
      } else {
        return left(
          ServerFailure(res['message']),
        );
      }
    } catch (e) {
      if (e.toString().contains('409')) {
        return left(ServerFailure.fromResponse(
            0, 'user already exists or have the same phone number'));
      } else if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, GenerateOtp>> generateOtp(String email) async {
    try {
      final Map<String, dynamic> data = {'email': email};
      final res =
          await apiService.postData(endPoint: 'auth/generateotp', data: data);
      if (res['message'] == 'email founded and your OTP is generated') {
        return right(GenerateOtp.fromJson(res));
      } else {
        return left(
          ServerFailure(res['message']),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, ConfirmEmailModel>> confirmEmailByOtp(
      String id, int otp, bool isRegister) async {
    try {
      final Map<String, dynamic> data = {'OTP': otp, 'id': id};
      final res = await apiService.postData(
          endPoint: isRegister ? 'auth/confirmemail' : 'auth/forgetpassword',
          data: data);
      if (res['message'] == 'success') {
        return right(ConfirmEmailModel.fromJson(res));
      } else {
        return left(
          ServerFailure(res['message']),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, String>> resetPassword(
      String password, Map<String, dynamic> _data) async {
    try {
      final Map<String, dynamic> data = {
        'password': password,
        'repassword': password,
        'OTP': _data['otp']
      };
      final res = await apiService.postData(
          endPoint: 'auth/forgetpassword/${_data['userId']}', data: data);
      if (res['message'] == 'success') {
        return right('success');
      } else {
        return left(
          ServerFailure(res['message']),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
