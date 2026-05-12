import 'package:bloc_clean_arch/features/auth/domain/entities/auth_session_entity.dart';
import 'package:bloc_clean_arch/features/auth/domain/entities/user_entity.dart';

import '../dto/login_response_dto.dart';
import '../models/user_model.dart';
import 'user_mapper.dart';

/// Maps auth data-layer DTOs into domain entities.
class AuthSessionMapper {
  const AuthSessionMapper._();

  static AuthSessionEntity fromLoginResponse(LoginResponseDto dto) {
    return AuthSessionEntity(
      user: UserMapper.toEntity(dto.user),
      accessToken: dto.accessToken,
      refreshToken: dto.refreshToken,
    );
  }

  static AuthSessionEntity fromUserModel({
    required UserModel user,
    required String accessToken,
    String? refreshToken,
  }) {
    return AuthSessionEntity(
      user: UserMapper.toEntity(user),
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
