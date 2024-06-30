import 'package:equatable/equatable.dart';

class EditProfileModel extends Equatable {
  final String message;
  final User user;

  const EditProfileModel({
    required this.message,
    required this.user,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      message: json['message'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [message, user];
}

class User extends Equatable {
  final ProfilePic? profilePic;
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;
  final String phone;
  final int age;
  final String gender;
  final bool isDeleted;
  final bool isLoggedIn;
  final bool isConfirmEmail;
  final String role;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String? otp;
  final String customId;

  const User({
    required this.profilePic,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
    required this.phone,
    required this.age,
    required this.gender,
    required this.isDeleted,
    required this.isLoggedIn,
    required this.isConfirmEmail,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.otp,
    required this.customId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      profilePic: json['profile_pic'] != null
          ? ProfilePic.fromJson(json['profile_pic'])
          : null,
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      isDeleted: json['isDeleted'] as bool,
      isLoggedIn: json['isLoggedIn'] as bool,
      isConfirmEmail: json['isConfirmEmail'] as bool,
      role: json['role'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: json['__v'] as int,
      otp: json['OTP'] as String?,
      customId: json['customId'] as String,
    );
  }

  @override
  List<Object?> get props => [
        profilePic,
        id,
        firstName,
        lastName,
        userName,
        email,
        password,
        phone,
        age,
        gender,
        isDeleted,
        isLoggedIn,
        isConfirmEmail,
        role,
        status,
        createdAt,
        updatedAt,
        v,
        otp,
        customId,
      ];
}

class ProfilePic {
  String? secureUrl;
  String? publicId;

  ProfilePic({this.secureUrl, this.publicId});

  ProfilePic.fromJson(Map<String, dynamic> json) {
    secureUrl = json['secure_url'];
    publicId = json['public_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secure_url'] = secureUrl;
    data['public_id'] = publicId;
    return data;
  }
}
