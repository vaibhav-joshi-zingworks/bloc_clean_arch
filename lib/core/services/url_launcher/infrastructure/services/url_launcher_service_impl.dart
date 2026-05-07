import '../../xcore.dart';

/// Implementation of [UrlLauncherService].
/// 
/// It orchestrates URL launching by building the correct [Uri] based on the 
/// [UrlType] and then resolving the appropriate [UrlLaunchStrategy] from the factory.
class UrlLauncherServiceImpl implements UrlLauncherService {
  final UrlLaunchStrategyFactory _factory;

  UrlLauncherServiceImpl(this._factory);

  @override
  Future<bool> launch(String value, {UrlType type = UrlType.web, LaunchMode? mode}) async {
    // 1. Convert the raw string and type into a structured Uri
    final uri = _buildUri(value, type);

    // 2. Find the strategy that knows how to handle this specific Uri
    final strategy = _factory.resolve(uri);

    // 3. Delegate the launch to the strategy
    return strategy.launch(uri, mode: mode);
  }

  /// Helper to construct a standardized [Uri] for different communication protocols.
  Uri _buildUri(String value, UrlType? type) {
    switch (type) {
      case UrlType.tel:
        return Uri.parse("${UrlType.tel.name}:$value");

      case UrlType.sms:
        return Uri.parse("${UrlType.sms.name}:$value");

      case UrlType.mailto:
        return Uri.parse("${UrlType.mailto.name}:$value");

      case UrlType.whatsapp:
        // Format for WhatsApp: https://wa.me/<number>
        final clean = value.replaceAll(RegExp(r'[^\d]'), '');
        return Uri.parse("https://wa.me/$clean");

      case UrlType.maps:
        // Generic Google Maps search link
        return Uri.parse("https://maps.google.com/?q=$value");

      case UrlType.web:
        return Uri.parse(value);

      default:
        return Uri.parse(value);
    }
  }
}
