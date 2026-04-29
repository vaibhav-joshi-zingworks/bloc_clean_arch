import 'package:bloc_clean_arch/core/services/url_launcher/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmailUrlLaunchStrategy', () {
    test('should be instantiable', () {
      final strategy = EmailUrlLaunchStrategy();
      expect(strategy, isA<EmailUrlLaunchStrategy>());
    });
  });
}
