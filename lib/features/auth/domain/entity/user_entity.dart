import 'package:equatable/equatable.dart';

/// Represents a user within the domain layer.
/// 
/// This is a pure data class used by business logic and UI, 
/// decoupled from any data layer implementation or API structure.
class UserEntity extends Equatable {
  /// Unique identifier for the user.
  final int id;
  
  /// Full name of the user.
  final String name;
  
  /// Primary email address of the user.
  final String email;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, email];
}
