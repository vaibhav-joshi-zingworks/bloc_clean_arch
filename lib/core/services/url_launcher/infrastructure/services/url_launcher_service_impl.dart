import '../../xcore.dart';

class UrlLauncherServiceImpl implements UrlLauncherService {
  final UrlLaunchStrategyFactory _factory;

  UrlLauncherServiceImpl(this._factory);

  @override
  Future<bool> launch(String value, {UrlType type = UrlType.web, LaunchMode? mode}) async {
    final uri = _buildUri(value, type);

    final strategy = _factory.resolve(uri);

    return strategy.launch(uri, mode: mode);
  }

  Uri _buildUri(String value, UrlType? type) {
    switch (type) {
      case UrlType.tel:
        return Uri.parse("${UrlType.tel.name}:$value");

      case UrlType.sms:
        return Uri.parse("${UrlType.sms.name}:$value");

      case UrlType.mailto:
        return Uri.parse("${UrlType.mailto.name}:$value");

      case UrlType.whatsapp:
        final clean = value.replaceAll(RegExp(r'[^\d]'), '');
        return Uri.parse("https://wa.me/$clean");

      case UrlType.maps:
        return Uri.parse("https://maps.google.com/?q=$value");

      case UrlType.web:
        return Uri.parse(value);
      default:
        return Uri.parse(value);
    }
  }
}
