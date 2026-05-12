import '../models/user_model.dart';

/// Response payload returned by the login API.
class LoginResponseDto {
  final UserModel user;
  final String accessToken;
  final String? refreshToken;

  const LoginResponseDto({
    required this.user,
    required this.accessToken,
    this.refreshToken,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
    };
  }
}
