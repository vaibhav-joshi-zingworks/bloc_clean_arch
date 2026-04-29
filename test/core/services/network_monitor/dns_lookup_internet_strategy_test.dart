import 'package:bloc_clean_arch/core/services/network_monitor/domain/infrastructure/strategies/dns_lookup_internet_strategy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DnsLookupInternetStrategy', () {
    test('should be instantiable', () {
      final strategy = DnsLookupInternetStrategy();
      expect(strategy, isA<DnsLookupInternetStrategy>());
    });
  });
}
