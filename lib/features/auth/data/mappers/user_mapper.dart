import 'package:bloc_clean_arch/features/auth/data/models/user_model.dart';
import 'package:bloc_clean_arch/features/auth/domain/entities/user_entity.dart';

/// Maps auth data-layer DTOs into domain entities.
class UserMapper {
  const UserMapper._();

  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      name: model.name,
      email: model.email,
    );
  }
}
