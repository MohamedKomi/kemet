import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kemet/core/errors/failure.dart';
import 'package:kemet/features/settings/data/models/edit_profile_model.dart';

abstract class EditProfileRepo {
  Future<Either<Failures, EditProfileModel>> editProfile(
      String firstName,String lastName,int age,String phone);
 Future<Either<Failures, EditProfileModel>> editPhoto(File? image);
  Future<Either<Failures, String>> signOut();
}
