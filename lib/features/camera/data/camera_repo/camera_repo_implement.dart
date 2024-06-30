import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kemet/core/errors/failure.dart';
import 'package:kemet/features/camera/data/camera_repo/camera_repo.dart';

class CameraRepoImplement extends CameraRepo {
  @override
  Future<Either<Failures, String>> fetchPhoto(File? image) async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'image':
            await MultipartFile.fromFile(image!.path, filename: 'file.jpg'),
      });
      final res = await dio.post(
          'http://172.16.1.2:5000/predictHieroglyphsAPI',
          data: formData);

      if (res.data['class'] != null) {
        return right(res.data['class']);
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
