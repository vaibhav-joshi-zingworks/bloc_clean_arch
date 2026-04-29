import 'package:bloc_clean_arch/core/services/analytics/enum/analytics_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnalyticsType', () {
    test('should have expected values', () {
      expect(AnalyticsType.values, contains(AnalyticsType.firebase));
      expect(AnalyticsType.values.length, 1);
    });
  });
}
