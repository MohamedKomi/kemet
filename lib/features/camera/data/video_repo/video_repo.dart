import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kemet/features/camera/data/info_monument_model/info_monument_model.dart';

import '../../../../core/errors/failure.dart';

abstract class VideoRepo {
  Future<Either<Failures, Map<String, dynamic>>> fetchInfo(
      File? image, String lan);


  Future<Either<Failures, MonumentTranslation>> fetchInfoMonument(String name);
}
