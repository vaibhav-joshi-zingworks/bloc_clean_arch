import 'package:equatable/equatable.dart';

/// Represents a user within the domain layer.
class UserEntity extends Equatable {
  final int id;
  final String name;
  final String email;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, email];
}
