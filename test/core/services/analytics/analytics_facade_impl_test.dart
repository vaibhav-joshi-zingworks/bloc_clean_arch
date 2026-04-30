import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsStrategy extends Mock implements AnalyticsStrategy {}

void main() {
  late AnalyticsFacadeImpl facade;
  late MockAnalyticsStrategy mockStrategy;

  setUp(() {
    mockStrategy = MockAnalyticsStrategy();
    facade = AnalyticsFacadeImpl(mockStrategy);
  });

  group('AnalyticsFacadeImpl', () {
    test('init should call strategy.init', () async {
      when(() => mockStrategy.init(isEnabled: any(named: 'isEnabled'))).thenAnswer((_) async => {});
      await facade.init(isEnabled: false);
      verify(() => mockStrategy.init(isEnabled: false)).called(1);
    });

    test('logEvent should call strategy.logEvent', () async {
      when(() => mockStrategy.logEvent(any(), parameters: any(named: 'parameters'))).thenAnswer((_) async => {});
      await facade.logEvent('test');
      verify(() => mockStrategy.logEvent('test')).called(1);
    });

    test('setUserId should call strategy.setUserId', () async {
      when(() => mockStrategy.setUserId(any())).thenAnswer((_) async => {});
      await facade.setUserId('user123');
      verify(() => mockStrategy.setUserId('user123')).called(1);
    });

    test('setUserProperty should call strategy.setUserProperty', () async {
      when(() => mockStrategy.setUserProperty(any(), any())).thenAnswer((_) async => {});
      await facade.setUserProperty('prop', 'val');
      verify(() => mockStrategy.setUserProperty('prop', 'val')).called(1);
    });
  });
}
