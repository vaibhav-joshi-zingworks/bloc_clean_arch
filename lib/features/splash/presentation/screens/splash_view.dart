import 'package:bloc_clean_arch/app/router/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core.dart';
import '../../domain/entities/app_status.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

/// The entry point view of the application.
/// 
/// Shows a loading indicator while the [SplashBloc] determines 
/// the next navigation destination based on the app's status.
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Initialize the Bloc and trigger the 'started' event
      create: (_) => sl<SplashBloc>()..add(const SplashEvent.started()),
      child: AppScaffold(
        body: BlocConsumer<SplashBloc, SplashState>(builder: (context, state) {
          // Render UI based on current state
          return state.when(
            initial: () => const SizedBox(),
            loading: () => AppLoadingWidget(),
            loaded: (_) => const SizedBox(), 
            error: (message) => Center(
              child: Text("Error: $message"),
            ),
          );
        }, listener: (context, state) {
          // React to states that trigger navigation
          state.whenOrNull(
            loaded: (status) {
              switch (status) {
                case AppStatus.authenticated:
                  // TODO: Navigate to Home Screen
                  break;
                case AppStatus.unauthenticated:
                  // Navigate to Login Screen
                  Global.navigatorKey.currentContext!.pushNamed(RouteName.login);
                  break;
                case AppStatus.firstLaunch:
                  // Navigate to Onboarding Screen (using Login as placeholder)
                  Global.navigatorKey.currentContext!.pushNamed(RouteName.login);
                  break;
              }
            },
            error: (message) {
              // Handle initialization errors
              debugPrint("Error: $message");
            },
          );
        }),
      ),
    );
  }
}
