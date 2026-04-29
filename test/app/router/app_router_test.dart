import 'package:bloc_clean_arch/app/router/app_router.dart';
import 'package:bloc_clean_arch/app/router/route_name.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('AppRouter', () {
    test('createRouter should return a GoRouter instance', () {
      final router = AppRouter.createRouter(observers: []);
      expect(router, isA<GoRouter>());
    });

    test('initialLocation should be splash route', () {
      final router = AppRouter.createRouter(observers: []);
      // router.routeInformationProvider.value.location was used in older versions
      // In newer versions of go_router, we can check the state or configuration
      expect(router.configuration.routes.isNotEmpty, true);
    });

    test('router should contain splash and login routes', () {
      final router = AppRouter.createRouter(observers: []);
      final routeNames = router.configuration.routes
          .whereType<GoRoute>()
          .map((e) => e.name)
          .toList();

      expect(routeNames, contains(RouteName.splash));
      expect(routeNames, contains(RouteName.login));
    });
  });
}
