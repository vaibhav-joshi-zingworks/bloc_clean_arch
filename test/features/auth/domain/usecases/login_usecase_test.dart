import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';
import 'package:bloc_clean_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(repository: mockAuthRepository);
  });

  final tUser = UserEntity(id: 1, name: 'Test', email: 'test@test.com');
  final tLoginParams = LoginParams(email: 'test@test.com', password: 'password');

  test('should call login on the repository with correct parameters', () async {
    // arrange
    when(() => mockAuthRepository.login(
      email: any(named: 'email'),
      password: any(named: 'password'),
    )).thenAnswer((_) async => Right(tUser));

    // act
    final result = await useCase(tLoginParams);

    // assert
    expect(result, Right(tUser));
    verify(() => mockAuthRepository.login(
      email: tLoginParams.email,
      password: tLoginParams.password,
    )).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when repository login fails', () async {
    // arrange
    final tFailure = UnauthorizedError();
    when(() => mockAuthRepository.login(
      email: any(named: 'email'),
      password: any(named: 'password'),
    )).thenAnswer((_) async => Left(tFailure));

    // act
    final result = await useCase(tLoginParams);

    // assert
    expect(result, Left(tFailure));
    verify(() => mockAuthRepository.login(
      email: tLoginParams.email,
      password: tLoginParams.password,
    )).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
