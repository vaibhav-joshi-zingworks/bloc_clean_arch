import 'package:bloc_clean_arch/core/services/url_launcher/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UrlLaunchStrategyFactory factory;

  setUp(() {
    factory = UrlLaunchStrategyFactory();
  });

  group('UrlLaunchStrategyFactory', () {
    test('resolve should return TelUrlLaunchStrategy for tel URI', () {
      final strategy = factory.resolve(Uri.parse('tel:123456'));
      expect(strategy, isA<TelUrlLaunchStrategy>());
    });

    test('resolve should return WebUrlLaunchStrategy for https URI', () {
      final strategy = factory.resolve(Uri.parse('https://google.com'));
      expect(strategy, isA<WebUrlLaunchStrategy>());
    });

    test('resolve should return WhatsAppUrlLaunchStrategy for wa.me URI', () {
      final strategy = factory.resolve(Uri.parse('https://wa.me/123'));
      expect(strategy, isA<WhatsAppUrlLaunchStrategy>());
    });
  });
}
