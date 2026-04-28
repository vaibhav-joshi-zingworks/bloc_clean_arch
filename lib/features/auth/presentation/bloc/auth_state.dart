import 'package:equatable/equatable.dart';
import '../../../../core.dart';

import '../../domain/entity/user_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  AuthSuccess({required this.user});
  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final AppException appException;
  AuthFailure({required this.appException});
  @override
  List<Object?> get props => [appException];
}