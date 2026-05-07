import '../core.dart';

/// A collection of static utility methods for common UI and logic tasks.
class Utils {
  
  /// Returns the appropriate [Color] for a specific [MessageType].
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

  /// Displays a highly-customizable [SnackBar] using the global [ScaffoldMessenger].
  /// 
  /// [message] is the body text.
  /// [titleText] is an optional headline.
  /// [result] determines the color scheme and icon.
  static void snackBar(String message,
      {String? titleText,
      MessageType result = MessageType.general,
      int duration = 2}) {
    // Access the global messenger state
    final messenger = Global.scaffoldMessengerKey.currentState;

    if (messenger == null) return;

    IconData iconData;
    Color iconColor = AppColorPalette.white;
    Color textColor = AppColorPalette.white;

    // Select icon based on the message type
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

    // Clear existing snackbars and show the new one
    messenger
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}
