import 'package:bloc_clean_arch/app/router/route_name.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RouteName', () {
    test('splash route should be correct', () {
      expect(RouteName.splash, '/');
    });

    test('login route should be correct', () {
      expect(RouteName.login, '/login');
    });
  });
}
