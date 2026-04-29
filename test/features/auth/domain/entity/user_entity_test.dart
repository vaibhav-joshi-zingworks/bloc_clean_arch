import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserEntity', () {
    test('should support value equality', () {
      final user1 = UserEntity(id: 1, name: 'A', email: 'a@a.com');
      final user2 = UserEntity(id: 1, name: 'A', email: 'a@a.com');
      
      expect(user1, equals(user2));
    });
  });
}
