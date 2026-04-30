import 'package:bloc_clean_arch/core/services/url_launcher/infrastructure/strategies/email_url_launch_strategy.dart';
import 'package:bloc_clean_arch/core/services/url_launcher/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmailUrlLaunchStrategy', () {
    test('should be instantiable', () {
      final strategy = MailtoUrlLaunchStrategy();
      expect(strategy, isA<MailtoUrlLaunchStrategy>());
    });
  });
}
