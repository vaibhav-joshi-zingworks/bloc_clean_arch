import '../dto/login_response_dto.dart';

/// Remote authentication operations.
abstract class AuthRemoteDataSource {
  Future<LoginResponseDto> login({
    required String email,
    required String password,
  });
}
