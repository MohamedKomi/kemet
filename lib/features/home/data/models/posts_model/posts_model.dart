import 'package:equatable/equatable.dart';

import 'post_data_model.dart';

class PostsModel extends Equatable {
  final String message;
  final List<PostData> postsAfterTranslate;

  const PostsModel({
    required this.message,
    required this.postsAfterTranslate,
  });

  @override
  List<Object?> get props => [message, postsAfterTranslate];

  factory PostsModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> postsJson = json['postsAfterTranslate'];
    final posts = postsJson.map((postJson) {
      return PostData.fromJson(postJson as Map<String, dynamic>);
    }).toList();

    return PostsModel(
      message: json['message'] as String,
      postsAfterTranslate: posts,
    );
  }
}

class LikesModel {
  final String message;
  final int likesCounter;
  final List likes;

  LikesModel(
      {required this.message, required this.likesCounter, required this.likes});

  factory LikesModel.fromJson(Map<String, dynamic> json) {
    return LikesModel(
        message: json['message'] as String,
        likesCounter: json['likesCounter'] as int,
        likes: json['likes']);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'likesCounter': likesCounter,
      'likes': likes,
    };
  }
}
