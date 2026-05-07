import 'package:bloc_clean_arch/app/router/route_name.dart';
import 'package:bloc_clean_arch/app/router/router_extension.dart';
import 'package:bloc_clean_arch/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/splash/presentation/screens/splash_view.dart';

/// Centralized router configuration using GoRouter.
/// 
/// This class defines all available routes and their associated views.
class AppRouter {
  /// Creates and configures the [GoRouter] instance.
  static GoRouter createRouter({
    required List<NavigatorObserver> observers,
  }) {
    return GoRouter(
      navigatorKey: Global.navigatorKey,
      initialLocation: RouteName.splash.path,
      debugLogDiagnostics: kDebugMode, // Enable logging for easier debugging
      observers: observers,
      requestFocus: false,

      routes: [
        // Splash Screen - Entry point of the app
        GoRoute(
          name: RouteName.splash,
          path: RouteName.splash.path,
          builder: (context, state) => const SplashView(),
        ),
        
        // Authentication - Login Screen
        GoRoute(
          name: RouteName.login,
          path: RouteName.login.path,
          builder: (_, __) => BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const LoginPage(),
          ),
        ),

      ],
    );
  }
}
