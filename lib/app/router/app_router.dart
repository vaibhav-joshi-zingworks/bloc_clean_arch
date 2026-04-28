import 'package:bloc_clean_arch/app/router/route_name.dart';
import 'package:bloc_clean_arch/app/router/router_extension.dart';
import 'package:go_router/go_router.dart';

import '../../core.dart';
import '../../features/splash/presentation/screens/splash_view.dart';

class AppRouter {
  static GoRouter createRouter({
    required List<NavigatorObserver> observers,
  }) {
    return GoRouter(
      navigatorKey: Global.navigatorKey,
      initialLocation: RouteName.splash.path,
      debugLogDiagnostics: kDebugMode,
      observers: observers,
      requestFocus: false,

      routes: [
        GoRoute(
          name: RouteName.splash,
          path: RouteName.splash.path,
          builder: (context, state) => const SplashView(),
        ),
      ],
    );
  }
}
