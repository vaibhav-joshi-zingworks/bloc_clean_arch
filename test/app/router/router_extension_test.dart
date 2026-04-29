import 'package:bloc_clean_arch/app/router/router_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RoutePathExtension', () {
    test('should add leading slash if missing', () {
      const path = 'home';
      expect(path.path, '/home');
    });

    test('should not add leading slash if already present', () {
      const path = '/home';
      expect(path.path, '/home');
    });
  });
}
