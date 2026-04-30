import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/core.dart';
import '../../core/design/responsive_context.dart';
import '../../features/settings/xcore.dart';
import '../providers/global_message_cubit.dart';
import '../providers/locale_cubit.dart';
import '../xcore.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    // ✅ Initialize app (BLoC way)
    Future.microtask(() {
      sl<AppInitializerCubit>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = sl<GoRouter>();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<ThemeCubit>()..loadTheme()),
        BlocProvider.value(value: sl<LocaleCubit>()),
        BlocProvider.value(value: sl<GlobalMessageCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleCubit, Locale?>(
            builder: (context, locale) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                scaffoldMessengerKey: Global.scaffoldMessengerKey,

                // 🌙 Theme
                themeMode: themeState.mode,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,

                // 🌍 Locale
                locale: locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates:
                AppLocalizations.localizationsDelegates,

                // 🚀 Router
                routerConfig: router,

                // ✨ Animation
                themeAnimationDuration:
                const Duration(milliseconds: 300),
                themeAnimationCurve: Curves.easeInOut,

                builder: (context, child) {
                  return GlobalMessageListener(
                    child: MediaQuery(
                      data: context.getTextMediaQueryData,
                      child: child!,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
