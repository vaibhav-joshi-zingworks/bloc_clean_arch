

import '../xcore.dart';

class UrlLaunchStrategyFactory {
  List<UrlLaunchStrategy> createStrategies() {
    return [
      WebUrlLaunchStrategy(),
      WhatsAppUrlLaunchStrategy(),
      MapsUrlLaunchStrategy(),
      TelUrlLaunchStrategy(),
      SmsUrlLaunchStrategy(),
      MailtoUrlLaunchStrategy(),
    ];
  }

  UrlLaunchStrategy resolve(Uri uri) {
    final strategies = createStrategies();

    return strategies.firstWhere((strategy) => strategy.supports(uri), orElse: () => WebUrlLaunchStrategy());
  }
}
