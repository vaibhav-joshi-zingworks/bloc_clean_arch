import '../core.dart';

/// A utility class containing static helper methods for UI-related tasks.
/// 
/// The [Utils] class centralizes logic that is commonly used across different 
/// parts of the application's presentation layer, such as color mapping and 
/// global notification display.
class Utils {
  
  /// Maps a [MessageType] enum to its corresponding [Color] from the theme palette.
  /// 
  /// [result] - The type of message (error, success, etc.) to get the color for.
  static Color getColor(MessageType result) {
    switch (result) {
      case MessageType.error:
        return AppColorPalette.red;
      case MessageType.success:
        return AppColorPalette.green;
      case MessageType.general:
        return AppColorPalette.primary;
      case MessageType.info:
        return AppColorPalette.blueAccent;
      case MessageType.warning:
        return AppColorPalette.orangeAccent;
    }
  }

  /// Displays a standardized [SnackBar] across the application.
  /// 
  /// This method uses the [Global.scaffoldMessengerKey] to ensure that 
  /// notifications can be triggered from anywhere, including BLoCs or 
  /// services, without requiring a [BuildContext].
  /// 
  /// * [message]: The primary content of the snackbar.
  /// * [titleText]: An optional bold header for the snackbar.
  /// * [result]: The [MessageType] which controls the background color and icon.
  /// * [duration]: How long (in seconds) the snackbar remains visible.
  static void snackBar(String message,
      {String? titleText,
      MessageType result = MessageType.general,
      int duration = 2}) {
    
    // Retrieve the current messenger state from the global key
    final messenger = Global.scaffoldMessengerKey.currentState;

    if (messenger == null) return;

    IconData iconData;
    Color iconColor = AppColorPalette.white;
    Color textColor = AppColorPalette.white;

    // Determine the icon based on the message type
    switch (result) {
      case MessageType.error:
        iconData = Icons.error;
        break;
      case MessageType.success:
        iconData = Icons.check_circle;
        break;
      case MessageType.general:
        iconData = Icons.info;
        break;
      case MessageType.info:
        iconData = Icons.info_outline;
        break;
      case MessageType.warning:
        iconData = Icons.warning_amber;
        break;
    }

    // Construct the customized SnackBar widget
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: getColor(result),
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: ListTile(
        minLeadingWidth: 10,
        horizontalTitleGap: 10,
        leading: Icon(iconData, size: 25, color: iconColor),
        title: titleText == null
            ? Text(message, style: TextStyle(color: textColor, fontSize: 12))
            : Text(titleText,
                style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
        subtitle: titleText == null
            ? null
            : Text(message, style: TextStyle(color: textColor, fontSize: 12)),
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      ),
    );

    // Clear any active snackbars before showing the new one
    messenger
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}
