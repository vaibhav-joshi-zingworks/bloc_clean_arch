import '../../../core.dart';

/// Service that monitors the application's lifecycle states (Foreground, Background, etc.).
/// 
/// It implements [WidgetsBindingObserver] to react to global app events, 
/// which is useful for pausing/resuming sensors, analytics, or security features.
class AppLifecycleService with WidgetsBindingObserver {
  static final AppLifecycleService _instance = AppLifecycleService._internal();
  
  /// Stores the current state of the application.
  late AppLifecycleState appState;

  factory AppLifecycleService() => _instance;

  AppLifecycleService._internal();

  /// Registers the service as a global observer of the widget binding.
  void init() {
    WidgetsBinding.instance.addObserver(this);
    appState = AppLifecycleState.resumed;
    debugPrint("🚀 AppLifecycleService initialized");
  }

  /// Removes the observer to prevent memory leaks.
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    debugPrint("🧹 AppLifecycleService disposed");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appState = state;
    
    // Log helpful messages for each state transition during development
    final message = switch (state) {
      AppLifecycleState.resumed => "App is in foreground running state",
      AppLifecycleState.inactive => "⚠️ App is inactive (e.g., phone call or app switch)",
      AppLifecycleState.paused => "🕒 App is paused (running in background)",
      AppLifecycleState.detached => "❌ App is detaching (may terminate soon)",
      AppLifecycleState.hidden => "👀 App window hidden (web/desktop only)",
    };

    debugPrint("🔄 Lifecycle Event → $message");
  }
}
