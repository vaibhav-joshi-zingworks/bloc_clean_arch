import 'package:bloc_clean_arch/core/services/url_launcher/infrastructure/strategies/whatsapp_url_launch_strategy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late WhatsAppUrlLaunchStrategy strategy;

  setUp(() {
    strategy = WhatsAppUrlLaunchStrategy();
  });

  group('WhatsAppUrlLaunchStrategy', () {
    test('supports should return true for wa.me links', () {
      final uri = Uri.parse('https://wa.me/1234567890');
      expect(strategy.supports(uri), true);
    });

    test('supports should return false for non wa.me links', () {
      final uri = Uri.parse('https://google.com');
      expect(strategy.supports(uri), false);
    });
  });
}
