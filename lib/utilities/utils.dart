import '../core.dart';
import 'enums/enums.dart';

class Utils {

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

  static void snackBar(String message, {String? titleText, MessageType result = MessageType.general, int duration = 2}) {
    final context = NavigationService.context;

    if (context == null) return;

    IconData iconData;
    Color iconColor = AppColorPalette.white;
    Color textColor = AppColorPalette.white;

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
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: ListTile(
        minLeadingWidth: 10,
        horizontalTitleGap: 10,
        leading: Icon(iconData, size: 25, color: iconColor),
        title: titleText == null
            // ? AppTextWidget(text: message, fontSize: 12, color: textColor)
            ? Text(message, style: TextStyle(color: textColor,fontSize: 12))
              : Text(titleText, style: TextStyle(color: textColor,fontSize: 14,fontWeight: FontWeight.w600)),
        subtitle: titleText == null ? null : Text(message, style: TextStyle(color: textColor,fontSize: 12)),
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      ),
    );

    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}