import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app_bloc_observer.dart';
import 'app/view/app.dart';
import 'core.dart';

/// Logs the current environment configuration for debugging purposes.
void logEnv() {
  debugPrint('🚀 ===== ENV CONFIG =====');
  debugPrint('Flavor: ${Env.flavor}');
  debugPrint('Host: ${Env.host}');
  debugPrint('Base URL: ${Env.baseUrl}');
  debugPrint('Image Base URL: ${Env.imageBaseUrl}');
  debugPrint('Encryption Key: ${Env.appEncryptionKey}');
  debugPrint('========================');
}

/// The main entry point of the application.
/// 
/// This function initializes the Flutter framework, Firebase, dependency injection,
/// and sets up the global BLoC observer before running the [App].
Future<void> main() async {
  // Ensure that plugin services are initialized so that `initializeApp` can be called.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase core services
  try {
    await Firebase.initializeApp();
  } catch (e, st) {
    debugPrint('Firebase.initializeApp failed: $e');
    debugPrint('$st');
  }

  // Initialize dependency injection (GetIt)
  await initDependencies();

  // Print environment variables to the console in debug mode
  logEnv();

  // Assign a global observer to monitor BLoC/Cubit state changes
  Bloc.observer = AppBlocObserver();

  // Start the root application widget
  runApp(const App());
}
