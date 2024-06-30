import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String message;
  final UserData? user;
  final String? token;

  const AuthModel(
      {required this.token, required this.message, required this.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        message: json['message'] as String,
        user: json['user'] != null ? UserData.fromJson(json['user']) : null,
        token: json['token'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'user': user?.toJson(),
        'token': token,
      };

  @override
  List<Object?> get props => [
        message,
        user,
        token,
      ];
}

class UserData extends Equatable {
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
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;
  final int otp;
  final ProfilePic profilePic;

  const UserData({
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
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.otp,
    required this.profilePic,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      age: json['age'],
      gender: json['gender'],
      isDeleted: json['isDeleted'],
      isLoggedIn: json['isLoggedIn'],
      isConfirmEmail: json['isConfirmEmail'],
      role: json['role'],
      status: json['status'],
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      otp: json['OTP'] == null ? 1234 : json['OTP'] as int,
      profilePic: ProfilePic.fromJson(json['profile_pic'] ??
          {
            'secure_url':
                'https://cdn-icons-png.flaticon.com/512/149/149071.png',
            'public_id': '',
          }),
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'userName': userName,
        'email': email,
        'password': password,
        'phone': phone,
        'age': age,
        'gender': gender,
        'isDeleted': isDeleted,
        'isLoggedIn': isLoggedIn,
        'isConfirmEmail': isConfirmEmail,
        'role': role,
        'status': status,
        '_id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
        'OTP': otp,
        'profile_pic': profilePic,
      };

  @override
  List<Object?> get props => [
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
        id,
        createdAt,
        updatedAt,
        v,
        otp,
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
    data['secure_url'] =
        secureUrl ?? 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
    data['public_id'] = publicId ?? '';
    return data;
  }

  @override
  List<Object?> get props => [secureUrl, publicId];
}
