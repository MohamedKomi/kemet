import 'package:dartz/dartz.dart';
import 'package:kemet/features/home/data/models/add_post_model/AddPostModel.dart';
import 'package:kemet/features/home/data/models/posts_model/posts_model.dart';

import '../../../../core/errors/failure.dart';
import '../models/places_model/Places.dart';

abstract class HomeRepo {
  Future<Either<Failures, Places>> fetchPlaces();

  Future<Either<Failures, PostsModel>> fetchPssts();

  Future<Either<Failures, LikesModel>> fetchLikes(String postId, String status);

  Future<Either<Failures, AddPostModel>> addPssts(Map<String, dynamic> data);
}
