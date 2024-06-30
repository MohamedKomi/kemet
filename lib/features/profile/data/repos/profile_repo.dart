import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../home/data/models/posts_model/posts_model.dart';

abstract class ProfileRepo{
  Future<Either<Failures,PostsModel>> fetchUserPosts();
  Future<Either<Failures,String>> deleteUserPosts(String id);
}