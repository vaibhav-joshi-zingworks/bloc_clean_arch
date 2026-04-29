import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AwesomeNotificationsAdapter', () {
    test('should be instantiable', () {
      final adapter = AwesomeNotificationsAdapter();
      expect(adapter, isA<AwesomeNotificationsAdapter>());
    });
  });
}
