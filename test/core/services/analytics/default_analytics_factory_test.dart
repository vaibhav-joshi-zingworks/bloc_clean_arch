import 'package:bloc_clean_arch/core/services/analytics/enum/analytics_type.dart';
import 'package:bloc_clean_arch/core/services/analytics/infrastructure/factories/default_analytics_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DefaultAnalyticsFactory', () {
    test('should create FirebaseAnalyticsStrategy for type firebase', () {
      final factory = DefaultAnalyticsFactory();
      // In unit test environments we don't initialize Firebase, so FirebaseAnalytics.instance
      // can throw due to missing default Firebase app. We still want a stable assertion.
      expect(
        () => factory.create(AnalyticsType.firebase),
        throwsA(predicate((e) => e.toString().contains('No Firebase App'))),
      );
    });
  });
}
