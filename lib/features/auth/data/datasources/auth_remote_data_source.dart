import 'package:bloc_clean_arch/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));

    if(email == 'test' && password == 'test'){
      return UserModel(id: 1, name: 'Test', email: email);
    }else{
      throw Exception('Invalid credentials');
    }
  }

}