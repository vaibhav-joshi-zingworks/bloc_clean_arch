import 'package:bloc_clean_arch/core/services/analytics/domain/factories/analytics_factory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsFactory extends Mock implements AnalyticsFactory {}

void main() {
  group('AnalyticsFactory', () {
    test('can be mocked', () {
      final factory = MockAnalyticsFactory();
      expect(factory, isA<AnalyticsFactory>());
    });
  });
}
