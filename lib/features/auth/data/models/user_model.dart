import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';

import '../../../../core.dart';

part 'user_model.g.dart';

/// Data Transfer Object (DTO) for the User entity.
/// 
/// Extends [UserEntity] and adds JSON serialization logic 
/// specific to the data layer.
@JsonSerializable()
class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  /// Creates a [UserModel] from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Converts the [UserModel] into a JSON map.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
