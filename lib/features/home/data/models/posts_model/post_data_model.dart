import 'package:equatable/equatable.dart';

import 'image_data_model.dart';

class PostData extends Equatable {
  final String descAfterTranslate;
  final Post post;

  const PostData({
    required this.descAfterTranslate,
    required this.post,
  });

  @override
  List<Object?> get props => [descAfterTranslate, post];

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      descAfterTranslate: json['descAfterTranslate'] as String,
      post: Post.fromJson(json['post'] as Map<String, dynamic>),
    );
  }
}

class Post extends Equatable {
  final String id;
  final String desc;
  final CreatedBy createdBy;
  final List<ImageData> images;
  final String location;
  final List<String> likes;
  final int likesCounter;
  final String createdAt;
  final String updatedAt;
  final int v;

  const Post({
    required this.id,
    required this.desc,
    required this.createdBy,
    required this.images,
    required this.location,
    required this.likes,
    required this.likesCounter,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  @override
  List<Object?> get props => [
        id,
        desc,
        images,
        location,
        likes,
        likesCounter,
        createdAt,
        updatedAt,
        v,
      ];

  factory Post.fromJson(Map<String, dynamic> json) {
    final List<dynamic> imagesJson = json['images'];
    final images = imagesJson.map((imageJson) {
      return ImageData.fromJson(imageJson as Map<String, dynamic>);
    }).toList();

    return Post(
      id: json['_id'] as String,
      desc: json['desc'] as String,
      createdBy: CreatedBy.fromJson(json['createdBy']),
      images: images,
      location: json['location'] as String,
      likes: (json['likes'] as List<dynamic>)
          .map((like) => like.toString())
          .toList(),
      likesCounter: json['likesCounter'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: json['__v'] as int,
    );
  }
}

class CreatedBy extends Equatable {
  final String? sId;
  final String? userName;
  final ProfilePic? profilePic;

  const CreatedBy(
      {required this.sId, required this.userName, required this.profilePic});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
        sId: json['_id'] ?? '',
        userName: json['userName'] ?? '',
        profilePic: ProfilePic.fromJson(json['profile_pic'] ??
            {
              'secure_url':
                  'https://cdn-icons-png.flaticon.com/512/149/149071.png',
              'public_id': ''
            }));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;

    data['profile_pic'] = profilePic!.toJson();

    return data;
  }

  @override
  List<Object?> get props => [
        sId,
        userName,
        profilePic,
      ];
}

class ProfilePic extends Equatable {
  final String? secureUrl;
  final String? publicId;

  const ProfilePic({required this.secureUrl, required this.publicId});

  factory ProfilePic.fromJson(Map<String, dynamic> json) {
    return ProfilePic(
        secureUrl: json['secure_url'] ??
            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
        publicId: json['public_id'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secure_url'] = secureUrl;
    data['public_id'] = publicId;
    return data;
  }

  @override
  List<Object?> get props => [secureUrl, publicId];
}
