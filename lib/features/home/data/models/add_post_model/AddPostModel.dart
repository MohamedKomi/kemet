import 'Post.dart';

class AddPostModel {
  AddPostModel({
      this.message, 
      this.post,});

  AddPostModel.fromJson(dynamic json) {
    message = json['message'];
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
  }
  String? message;
  Post? post;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (post != null) {
      map['post'] = post?.toJson();
    }
    return map;
  }

}