import 'package:equatable/equatable.dart';

class GenerateOtp extends Equatable {
  final String message;
  final String userId;

  const GenerateOtp({required this.message, required this.userId});

  factory GenerateOtp.fromJson(Map<String, dynamic> json) => GenerateOtp(
        message: json['message'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'userId': userId,
      };

  @override
  List<Object?> get props => [
        message,
        userId,
      ];
}
