import 'package:bloc_clean_arch/core/services/analytics/domain/facades/analytics_facade.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsFacade extends Mock implements AnalyticsFacade {}

void main() {
  group('AnalyticsFacade', () {
    test('can be mocked', () {
      final facade = MockAnalyticsFacade();
      expect(facade, isA<AnalyticsFacade>());
    });
  });
}
