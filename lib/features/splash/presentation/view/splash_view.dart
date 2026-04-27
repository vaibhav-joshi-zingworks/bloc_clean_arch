import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core.dart';
import '../../domain/entities/app_status.dart';
import '../bloc/splash_cubit.dart';
import '../bloc/splash_state.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SplashCubit>()..init(),
      child: AppScaffold(
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            final status = state.status;

            if (status == null) return;

            switch (status) {
              case AppStatus.authenticated:
                break;

              case AppStatus.unauthenticated:
                break;

              case AppStatus.firstLaunch:
                break;
            }
          },
          child: const Center(
            child: AppTextWidget(
              text: "Welcome to bloc structure Application",
              color: Colors.amberAccent,
            ),
          ),
        ),
      ),
    );
  }
}