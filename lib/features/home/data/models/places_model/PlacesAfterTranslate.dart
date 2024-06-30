import 'Images.dart';

class PlacesAfterTranslate {
  PlacesAfterTranslate({
    this.desc,
    this.placeName,
    this.id,
    this.location,
    this.images,
  });

  PlacesAfterTranslate.fromJson(dynamic json) {
    desc = json['desc'];
    placeName = json['placeName'];
    id = json['_id'];
    location = json['location'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }

  String? desc;
  String? placeName;
  String? id;
  List<Images>? images;
  String? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['desc'] = desc;
    map['placeName'] = placeName;
    map['_id'] = id;
    map['location'] = location;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
