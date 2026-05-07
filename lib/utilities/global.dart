import '../core.dart';

/// Global access point for key Flutter framework controllers.
/// 
/// This class provides static access to [GlobalKey] instances that are necessary 
/// for performing imperative actions (like navigation or showing snackbars) 
/// from deep within the business logic (BLoCs/Repositories) where a 
/// [BuildContext] might not be readily available.
class Global {
  // Private constructor to prevent instantiation.
  Global._();
  
  /// A global key for the [NavigatorState], used primarily by [GoRouter].
  /// 
  /// This key allows the application to perform navigation actions from 
  /// anywhere in the code.
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  /// A global key for [ScaffoldMessengerState], used to manage [SnackBar]s.
  /// 
  /// This key enables showing or hiding snackbars globally without needing 
  /// access to a local [ScaffoldMessenger] via context.
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
