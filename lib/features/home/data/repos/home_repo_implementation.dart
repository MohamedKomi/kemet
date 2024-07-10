import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kemet/core/errors/failure.dart';
import 'package:kemet/features/home/data/models/add_post_model/AddPostModel.dart';
import 'package:kemet/features/home/data/models/places_model/Places.dart';
import 'package:kemet/features/home/data/models/posts_model/posts_model.dart';
import 'package:kemet/features/home/data/repos/home_repo.dart';

import '../../../../core/utils/api_service.dart';

class HomeRepoImplement extends HomeRepo {
  final ApiService apiService;

  HomeRepoImplement(this.apiService);

  @override
  Future<Either<Failures, PostsModel>> fetchPssts() async {
    try {
      final res = await apiService.getData(endPoint: 'posts');

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
  Future<Either<Failures, LikesModel>> fetchLikes(
      String postId, String status) async {
    Map<String, dynamic> data = {"status": status, "postId": postId};
    try {
      final res = await apiService.postData(endPoint: 'posts/like', data: data);
      if (res['message'] == 'success') {
        return right(LikesModel.fromJson(res));
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
  Future<Either<Failures, AddPostModel>> addPssts(
      Map<String, dynamic> _data) async {
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          _data['image'],
          filename: 'file.jpg',
        ),
        'desc': _data['desc'],
        'location': _data['location']
      });

      final res = await apiService.postData(endPoint: 'posts', data: formData);
      if (res['message'] == 'post added successfully') {
        return right(AddPostModel.fromJson(res));
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
  Future<Either<Failures, Places>> fetchPlaces() async {
    try {
      final res = await apiService.getData(endPoint: 'places');
      if (res['message'] == 'success') {
        return right(Places.fromJson(res));
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
