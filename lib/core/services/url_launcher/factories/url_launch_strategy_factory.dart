

import '../xcore.dart';

class UrlLaunchStrategyFactory {
  List<UrlLaunchStrategy> createStrategies() {
    return [
      WhatsAppUrlLaunchStrategy(),
      MapsUrlLaunchStrategy(),
      TelUrlLaunchStrategy(),
      SmsUrlLaunchStrategy(),
      MailtoUrlLaunchStrategy(),
      WebUrlLaunchStrategy(),
    ];
  }

  UrlLaunchStrategy resolve(Uri uri) {
    final strategies = createStrategies();

    return strategies.firstWhere((strategy) => strategy.supports(uri), orElse: () => WebUrlLaunchStrategy());
  }
}
