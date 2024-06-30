import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kemet/core/errors/failure.dart';
import 'package:kemet/features/home/data/models/posts_model/posts_model.dart';
import 'package:kemet/features/profile/data/repos/profile_repo.dart';

import '../../../../core/utils/api_service.dart';

class ProfileRepoImplements extends ProfileRepo{
  final ApiService apiService;

  ProfileRepoImplements(this.apiService);
  @override
  Future<Either<Failures, PostsModel>> fetchUserPosts() async {
    try {
      final res = await apiService.getData(endPoint: 'posts/user');
      if (res['message'] == 'success') {
        return right(PostsModel.fromJson(res));
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
  Future<Either<Failures, String>> deleteUserPosts(String id) async {
    try {
      final res = await apiService.deleteData(endPoint: 'posts/$id');
      if (res['message'] != null) {
        return right(res['message']);
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