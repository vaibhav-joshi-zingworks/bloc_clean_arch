import 'package:bloc_clean_arch/core/services/network_monitor/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetCheckStrategy extends Mock implements InternetCheckStrategy {}

void main() {
  group('InternetCheckStrategy', () {
    test('can be mocked', () {
      final strategy = MockInternetCheckStrategy();
      expect(strategy, isA<InternetCheckStrategy>());
    });
  });
}
