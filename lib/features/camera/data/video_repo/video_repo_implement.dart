import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kemet/core/errors/failure.dart';
import 'package:kemet/core/utils/api_service.dart';
import 'package:kemet/features/camera/data/info_monument_model/info_monument_model.dart';
import 'package:kemet/features/camera/data/video_repo/video_repo.dart';

import '../../../../core/utils/shared_data.dart';

class VideoRepoImplement extends VideoRepo {
  final ApiService apiService;

  VideoRepoImplement(this.apiService);

  @override
  Future<Either<Failures, Map<String, dynamic>>> fetchInfo(
      File? image, String lan) async {
    try {
      FormData formData = FormData.fromMap({
        'image':
            await MultipartFile.fromFile(image!.path, filename: 'file.jpg'),
        'language': SharedData.getUserLan()
      });
      final res = await Dio().post(
          'http://172.16.1.2:5000/predictTourismAPI',
          data: formData);

      if (res.data['information'] != null) {
        return right(res.data);
      } else {
        return left(
          ServerFailure(res.data['error']),
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
  Future<Either<Failures, MonumentTranslation>> fetchInfoMonument(
      String name) async {
    Dio dio = Dio();
    try {
      dio.options.headers = {'token': SharedData.getToken()};
      final res = await dio.get(
          'https://kemet.onrender.com/monuments?monumentName=$name&lang=${SharedData.getUserLan()}');

      if (res.data['message'] == "success") {
        return right(MonumentTranslation.fromJson(res.data));
      } else {
        return left(
          ServerFailure(res.data['error']),
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
