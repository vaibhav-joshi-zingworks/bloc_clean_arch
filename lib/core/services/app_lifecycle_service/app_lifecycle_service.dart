import '../../../core.dart';

class AppLifecycleService with WidgetsBindingObserver {
  static final AppLifecycleService _instance = AppLifecycleService._internal();
  late AppLifecycleState appState;

  factory AppLifecycleService() => _instance;

  AppLifecycleService._internal();

  void init() {
    WidgetsBinding.instance.addObserver(this);
    appState = AppLifecycleState.resumed;
    debugPrint("🚀 AppLifecycleService initialized");
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    debugPrint("🧹 AppLifecycleService disposed");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appState = state;
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
