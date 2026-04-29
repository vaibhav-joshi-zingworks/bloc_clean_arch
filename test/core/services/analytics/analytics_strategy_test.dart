import 'package:bloc_clean_arch/core/services/analytics/domain/strategies/analytics_strategy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsStrategy extends Mock implements AnalyticsStrategy {}

void main() {
  group('AnalyticsStrategy', () {
    test('can be mocked', () {
      final strategy = MockAnalyticsStrategy();
      expect(strategy, isA<AnalyticsStrategy>());
    });
  });
}
