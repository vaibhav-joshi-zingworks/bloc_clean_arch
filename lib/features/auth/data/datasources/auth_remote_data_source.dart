import 'package:bloc_clean_arch/features/auth/data/models/user_model.dart';

/// Interface for remote authentication data operations.
abstract class AuthRemoteDataSource {
  /// Calls the authentication API endpoint.
  Future<UserModel> login({required String email, required String password});
}

/// Concrete implementation of [AuthRemoteDataSource] that interacts with a REST API.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login({required String email, required String password}) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock authentication logic
    if(email == 'test' && password == 'test'){
      return UserModel(id: 1, name: 'Test', email: email);
    } else {
      throw Exception('Invalid credentials');
    }
  }
}
