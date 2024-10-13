import 'package:audio_app/models/user.dart';

class UserProfileResponse {
  UserProfileResponse({
    required this.message,
    required this.data,
    this.success,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      message: json['message'],
      data: User.fromJson(json['data']),
      success: json['success'],
    );
  }
  final String message;
  final User data;
  final bool? success;
}
