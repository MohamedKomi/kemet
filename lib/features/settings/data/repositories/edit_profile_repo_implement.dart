import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kemet/core/errors/failure.dart';
import 'package:kemet/core/utils/api_service.dart';
import 'package:kemet/features/settings/data/models/edit_profile_model.dart';

import '../../../../core/utils/shared_data.dart';
import 'edit_profile_repo.dart';

class EditProfileRepoImplement extends EditProfileRepo {
  final ApiService apiService;

  EditProfileRepoImplement(this.apiService);

  @override
  Future<Either<Failures, EditProfileModel>> editProfile(
      String firstName, String lastName, int age, String phone) async {
    try {
      final Map<String, dynamic> data = {};
      if (age != SharedData.getUserAge()) {
        data['age'] = age;
      }
      if (phone != SharedData.getUserPhone()) {
        data['phone'] = phone;
      }
      if (firstName != SharedData.getUserName()!.split(" ").first) {
        data['firstName'] = firstName;
      }
      if (lastName != SharedData.getUserName()!.split(" ").last) {
        data['lastName'] = lastName;
      }

      final res = await apiService.putData(endPoint: 'user', data: data);
      if (res['message'] == 'updated done') {
        return right(EditProfileModel.fromJson(res));
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
  Future<Either<Failures, String>> signOut() async {
    try {
      final Dio dio = Dio();
      dio.options.headers = {'token': SharedData.getToken()};
      final res = await dio.get('https://kemet.onrender.com/user/logout');

      if (res.data['message'] == 'success logging out') {
        return right(res.data['message']);
      } else {
        return left(
          ServerFailure(res.data['message']),
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
  Future<Either<Failures, EditProfileModel>> editPhoto(File? image) async {
    try {
      FormData formData = FormData.fromMap({
        'profile_pic':
            await MultipartFile.fromFile(image!.path, filename: 'file.jpg'),
      });

      final res = await apiService.postData(
          endPoint: 'user/profile_pic', data: formData);
      if (res['message'] == 'done') {
        return right(EditProfileModel.fromJson(res));
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
