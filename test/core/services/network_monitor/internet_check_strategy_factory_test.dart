import 'package:bloc_clean_arch/core/services/network_monitor/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InternetCheckStrategyFactory', () {
    test('createDefault should return an InternetCheckStrategy', () {
      final strategy = InternetCheckStrategyFactory.createDefault();
      expect(strategy, isA<InternetCheckStrategy>());
    });
  });
}
