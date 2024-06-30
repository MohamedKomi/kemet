import 'PlacesAfterTranslate.dart';

class Places {
  Places({
    this.message,
    this.placesAfterTranslate,
  });

  Places.fromJson(dynamic json) {
    message = json['message'];
    if (json['placesAfterTranslate'] != null) {
      placesAfterTranslate = [];
      json['placesAfterTranslate'].forEach((v) {
        placesAfterTranslate?.add(PlacesAfterTranslate.fromJson(v));
      });
    }
  }

  String? message;
  List<PlacesAfterTranslate>? placesAfterTranslate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (placesAfterTranslate != null) {
      map['placesAfterTranslate'] =
          placesAfterTranslate?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
