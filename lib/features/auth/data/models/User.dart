 class User {
  User({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.userName, 
      this.email, 
      this.password, 
      this.phone, 
      this.age, 
      this.gender, 
      this.isDeleted, 
      this.isLoggedIn, 
      this.isConfirmEmail, 
      this.role, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.otp,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    age = json['age'];
    gender = json['gender'];
    isDeleted = json['isDeleted'];
    isLoggedIn = json['isLoggedIn'];
    isConfirmEmail = json['isConfirmEmail'];
    role = json['role'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    otp = json['OTP'];
  }
  String? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? password;
  String? phone;
  int? age;
  String? gender;
  bool? isDeleted;
  bool? isLoggedIn;
  bool? isConfirmEmail;
  String? role;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? v;
  dynamic otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['userName'] = userName;
    map['email'] = email;
    map['password'] = password;
    map['phone'] = phone;
    map['age'] = age;
    map['gender'] = gender;
    map['isDeleted'] = isDeleted;
    map['isLoggedIn'] = isLoggedIn;
    map['isConfirmEmail'] = isConfirmEmail;
    map['role'] = role;
    map['status'] = status;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['OTP'] = otp;
    return map;
  }

}