
import '../xcore.dart';

class InternetCheckStrategyFactory {
  static InternetCheckStrategy createDefault() {
    return DnsLookupInternetStrategy();
  }
}
