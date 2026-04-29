import 'package:bloc_clean_arch/features/auth/data/models/user_model.dart';
import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tUserModel = UserModel(id: 1, name: 'Test', email: 'test@test.com');

  group('UserModel', () {
    test('should be a subclass of UserEntity', () {
      expect(tUserModel, isA<UserEntity>());
    });

    test('fromJson should return a valid model', () {
      final json = {
        'id': 1,
        'name': 'Test',
        'email': 'test@test.com',
      };
      final result = UserModel.fromJson(json);
      expect(result.id, tUserModel.id);
      expect(result.name, tUserModel.name);
      expect(result.email, tUserModel.email);
    });

    test('toJson should return a JSON map containing proper data', () {
      final result = tUserModel.toJson();
      final expectedMap = {
        'id': 1,
        'name': 'Test',
        'email': 'test@test.com',
      };
      expect(result, expectedMap);
    });
  });
}
