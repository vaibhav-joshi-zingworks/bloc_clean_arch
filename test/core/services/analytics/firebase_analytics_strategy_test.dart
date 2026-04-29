import 'package:bloc_clean_arch/core/services/analytics/infrastructure/strategies/firebase_analytics_strategy.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

void main() {
  late FirebaseAnalyticsStrategy strategy;
  late MockFirebaseAnalytics mockAnalytics;

  setUp(() {
    mockAnalytics = MockFirebaseAnalytics();
    strategy = FirebaseAnalyticsStrategy(mockAnalytics);
  });

  group('FirebaseAnalyticsStrategy', () {
    test('init should enable collection and log app open', () async {
      when(() => mockAnalytics.setAnalyticsCollectionEnabled(any())).thenAnswer((_) async => {});
      when(() => mockAnalytics.logAppOpen()).thenAnswer((_) async => {});

      await strategy.init(isEnabled: true);

      verify(() => mockAnalytics.setAnalyticsCollectionEnabled(true)).called(1);
      verify(() => mockAnalytics.logAppOpen()).called(1);
    });

    test('logEvent should call analytics.logEvent when initialized', () async {
      when(() => mockAnalytics.setAnalyticsCollectionEnabled(any())).thenAnswer((_) async => {});
      when(() => mockAnalytics.logAppOpen()).thenAnswer((_) async => {});
      when(() => mockAnalytics.logEvent(name: any(named: 'name'), parameters: any(named: 'parameters')))
          .thenAnswer((_) async => {});

      await strategy.init();
      await strategy.logEvent('test_event', parameters: {'param': 'value'});

      verify(() => mockAnalytics.logEvent(name: 'test_event', parameters: {'param': 'value'})).called(1);
    });

    test('setUserId should call analytics.setUserId when initialized', () async {
      when(() => mockAnalytics.setAnalyticsCollectionEnabled(any())).thenAnswer((_) async => {});
      when(() => mockAnalytics.logAppOpen()).thenAnswer((_) async => {});
      when(() => mockAnalytics.setUserId(id: any(named: 'id'))).thenAnswer((_) async => {});

      await strategy.init();
      await strategy.setUserId('user123');

      verify(() => mockAnalytics.setUserId(id: 'user123')).called(1);
    });

    test('setUserProperty should call analytics.setUserProperty when initialized', () async {
      when(() => mockAnalytics.setAnalyticsCollectionEnabled(any())).thenAnswer((_) async => {});
      when(() => mockAnalytics.logAppOpen()).thenAnswer((_) async => {});
      when(() => mockAnalytics.setUserProperty(name: any(named: 'name'), value: any(named: 'value')))
          .thenAnswer((_) async => {});

      await strategy.init();
      await strategy.setUserProperty('prop', 'val');

      verify(() => mockAnalytics.setUserProperty(name: 'prop', value: 'val')).called(1);
    });
  });
}
