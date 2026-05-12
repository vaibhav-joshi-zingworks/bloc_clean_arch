import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';

/// Data Transfer Object (DTO) for the User entity.
/// 
/// Extends [UserEntity] and adds JSON serialization logic 
/// specific to the data layer.
class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  /// Creates a [UserModel] from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  /// Converts the [UserModel] into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
