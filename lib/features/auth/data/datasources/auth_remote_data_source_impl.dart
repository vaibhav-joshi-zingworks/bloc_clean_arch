import '../../../../core.dart';
import '../dto/login_request_dto.dart';
import '../dto/login_response_dto.dart';
import 'auth_remote_data_source.dart';

/// Remote authentication data source backed by [BaseApiService].
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final BaseApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<LoginResponseDto> login({
    required String email,
    required String password,
  }) async {
    final request = LoginRequestDto(email: email, password: password);

    // TODO: Replace mock login with a real API call via [_apiService].
    await Future.delayed(const Duration(seconds: 2));

    if (request.email == 'test' && request.password == 'test') {
      return LoginResponseDto.fromJson({
        'user': {
          'id': 1,
          'name': 'Test',
          'email': request.email,
        },
        'access_token': 'mock-access-token',
        'refresh_token': 'mock-refresh-token',
      });
    }

    throw Exception('Invalid credentials');
  }
}
