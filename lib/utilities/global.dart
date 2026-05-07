import '../core.dart';

/// Holds global [GlobalKey] instances used for app-wide navigation and messaging.
/// 
/// These keys allow performing actions (like navigation or showing snackbars) 
/// from outside the widget tree where a [BuildContext] might not be available.
class Global {
  Global._();
  
  /// Key for the primary [Navigator] used by [GoRouter].
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  /// Key for the [ScaffoldMessenger] to display [SnackBar]s globally.
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
