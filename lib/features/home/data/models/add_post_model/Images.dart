class Images {
  Images({
      this.secureUrl, 
      this.publicId, 
      this.id,});

  Images.fromJson(dynamic json) {
    secureUrl = json['secure_url'];
    publicId = json['public_id'];
    id = json['_id'];
  }
  String? secureUrl;
  String? publicId;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['secure_url'] = secureUrl;
    map['public_id'] = publicId;
    map['_id'] = id;
    return map;
  }

}