import 'Images.dart';

class Post {
  Post({
      this.desc, 
      this.customId, 
      this.createdBy, 
      this.images, 
      this.location, 
      this.likes, 
      this.likesCounter, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Post.fromJson(dynamic json) {
    desc = json['desc'];
    customId = json['customId'];
    createdBy = json['createdBy'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    location = json['location'];
    if (json['likes'] != null) {
      likes = [];
    }
    likesCounter = json['likesCounter'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? desc;
  String? customId;
  String? createdBy;
  List<Images>? images;
  String? location;
  List<dynamic>? likes;
  int? likesCounter;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['desc'] = desc;
    map['customId'] = customId;
    map['createdBy'] = createdBy;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    map['location'] = location;
    if (likes != null) {
      map['likes'] = likes?.map((v) => v.toJson()).toList();
    }
    map['likesCounter'] = likesCounter;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}