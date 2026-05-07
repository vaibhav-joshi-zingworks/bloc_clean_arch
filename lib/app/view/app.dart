import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/core.dart';
import '../../core/design/responsive_context.dart';
import '../../features/settings/xcore.dart';
import '../providers/global_message_cubit.dart';
import '../providers/locale_cubit.dart';
import '../xcore.dart';

/// The root widget of the application.
/// 
/// It configures the global providers, theme, localization, and routing.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    // Trigger app-wide initialization logic (e.g., analytics, notifications)
    Future.microtask(() {
      sl<AppInitializerCubit>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access the global router instance from GetIt
    final router = sl<GoRouter>();

    return MultiBlocProvider(
      providers: [
        // Provide global Blocs/Cubits available throughout the widget tree
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

                // Configure Theme
                themeMode: themeState.mode,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,

                // Configure Localization
                locale: locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,

                // Configure Routing
                routerConfig: router,

                // Visual transitions for theme changes
                themeAnimationDuration: const Duration(milliseconds: 300),
                themeAnimationCurve: Curves.easeInOut,

                builder: (context, child) {
                  // GlobalMessageListener handles app-wide overlays/snackbars
                  return GlobalMessageListener(
                    child: MediaQuery(
                      // Ensure text scaling remains consistent across devices
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
