import 'package:bloc_clean_arch/app/router/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core.dart';
import '../../domain/entities/app_status.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SplashBloc>()..add(const SplashEvent.started()),
      child: AppScaffold(
        body: BlocConsumer<SplashBloc, SplashState>(builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => AppLoadingWidget(),
            loaded: (_) => const SizedBox(), // UI handled via navigation
            error: (message) => Center(
              child: Text("Error: $message"),
            ),
          );
        }, listener: (context, state) {
          state.whenOrNull(
            loaded: (status) {
              switch (status) {
                case AppStatus.authenticated:
                  // TODO: navigate to home
                  break;
                case AppStatus.unauthenticated:
                  Global.navigatorKey.currentContext!.pushNamed(RouteName.login);
                  // TODO: navigate to login
                  break;
                case AppStatus.firstLaunch:
                  Global.navigatorKey.currentContext!.pushNamed(RouteName.login);
                  // TODO: navigate to onboarding
                  break;
              }
            },
            error: (message) {
              // TODO: show error snackbar/dialog
              debugPrint("Error: $message");
            },
          );
        }),
      ),
    );
  }
}
