import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class CameraRepo {
  Future<Either<Failures, String>> fetchPhoto(File? image);
}
