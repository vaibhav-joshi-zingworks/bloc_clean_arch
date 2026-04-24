import '../../xcore.dart';

class FlutterUrlLauncherAdapter {
  const FlutterUrlLauncherAdapter();

  Future<bool> launch(Uri uri) async {
    if (!await canLaunchUrl(uri)) {
      return false;
    }

    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
