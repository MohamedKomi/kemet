import 'package:equatable/equatable.dart';

class MonumentTranslation extends Equatable {
  final String message;
  final Monument monumentAfterTranslate;

  MonumentTranslation({
    required this.message,
    required this.monumentAfterTranslate,
  });

  @override
  List<Object?> get props => [message, monumentAfterTranslate];

  factory MonumentTranslation.fromJson(Map<String, dynamic> json) {
    return MonumentTranslation(
      message: json['message'],
      monumentAfterTranslate: Monument.fromJson(json['monumentAfterTranslate']),
    );
  }
}

class Monument extends Equatable {
  final String desc;
  final String monumentName;
  final String id;
  final List<MonumentImage> images;

  Monument({
    required this.desc,
    required this.monumentName,
    required this.id,
    required this.images,
  });

  @override
  List<Object?> get props => [desc, monumentName, id, images];

  factory Monument.fromJson(Map<String, dynamic> json) {
    return Monument(
      desc: json['desc'],
      monumentName: json['monumentName'],
      id: json['_id'],
      images: (json['images'] as List<dynamic>)
          .map((image) => MonumentImage.fromJson(image))
          .toList(),
    );
  }
}

class MonumentImage extends Equatable {
  final String secureUrl;
  final String publicId;
  final String id;

  MonumentImage({
    required this.secureUrl,
    required this.publicId,
    required this.id,
  });

  @override
  List<Object?> get props => [secureUrl, publicId, id];

  factory MonumentImage.fromJson(Map<String, dynamic> json) {
    return MonumentImage(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
      id: json['_id'],
    );
  }
}
