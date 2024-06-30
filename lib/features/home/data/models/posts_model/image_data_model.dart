import 'package:equatable/equatable.dart';

class ImageData extends Equatable {
  final String secureUrl;
  final String publicId;
  final String id;

  ImageData({
    required this.secureUrl,
    required this.publicId,
    required this.id,
  });

  @override
  List<Object?> get props => [secureUrl, publicId, id];

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      secureUrl: json['secure_url'] as String,
      publicId: json['public_id'] as String,
      id: json['_id'] as String,
    );
  }
}
