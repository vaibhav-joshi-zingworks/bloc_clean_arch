
import '../xcore.dart';

/// Factory for creating [InternetCheckStrategy] instances.
class InternetCheckStrategyFactory {
  /// Creates the default strategy for verifying internet access.
  /// 
  /// Uses [DnsLookupInternetStrategy] as the primary implementation.
  static InternetCheckStrategy createDefault() {
    return DnsLookupInternetStrategy();
  }
}
