import '../xcore.dart';

/// Factory class for managing and resolving [UrlLaunchStrategy] instances.
/// 
/// It maintains a list of available strategies and provides logic to pick 
/// the most appropriate one for a given [Uri].
class UrlLaunchStrategyFactory {
  
  /// Returns a list of all supported URL launch strategies.
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

  /// Resolves the correct strategy for a specific [uri].
  /// 
  /// It iterates through all strategies and returns the first one that [supports] the URI.
  /// Falls back to [WebUrlLaunchStrategy] if no match is found.
  UrlLaunchStrategy resolve(Uri uri) {
    final strategies = createStrategies();

    return strategies.firstWhere(
      (strategy) => strategy.supports(uri), 
      orElse: () => WebUrlLaunchStrategy()
    );
  }
}
