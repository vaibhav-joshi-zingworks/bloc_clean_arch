import 'package:bloc_clean_arch/core/services/url_launcher/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UrlType and LaunchModeConfig', () {
    test('UrlType should include supported types', () {
      expect(
        UrlType.values,
        containsAll(<UrlType>[UrlType.web, UrlType.mailto, UrlType.sms, UrlType.whatsapp, UrlType.tel, UrlType.maps]),
      );
    });

    test('LaunchModeConfig should default to externalApplication', () {
      expect(LaunchModeConfig.defaultMode, LaunchMode.externalApplication);
    });
  });

  group('UrlLaunchStrategy.supports', () {
    test('WebUrlLaunchStrategy supports http/https', () {
      final strategy = WebUrlLaunchStrategy();
      expect(strategy.supports(Uri.parse('https://example.com')), isTrue);
      expect(strategy.supports(Uri.parse('http://example.com')), isTrue);
      expect(strategy.supports(Uri.parse('tel:123')), isFalse);
    });

    test('WhatsAppUrlLaunchStrategy supports wa.me', () {
      final strategy = WhatsAppUrlLaunchStrategy();
      expect(strategy.supports(Uri.parse('https://wa.me/123')), isTrue);
      expect(strategy.supports(Uri.parse('https://google.com')), isFalse);
    });

    test('MapsUrlLaunchStrategy supports google maps routes', () {
      final strategy = MapsUrlLaunchStrategy();
      expect(strategy.supports(Uri.parse('https://google.com/maps?q=test')), isTrue);
      expect(strategy.supports(Uri.parse('https://google.com/notes?q=test')), isFalse);
    });

    test('TelUrlLaunchStrategy supports tel', () {
      final strategy = TelUrlLaunchStrategy();
      expect(strategy.supports(Uri.parse('tel:1234567890')), isTrue);
      expect(strategy.supports(Uri.parse('sms:123')), isFalse);
    });

    test('SmsUrlLaunchStrategy supports sms', () {
      final strategy = SmsUrlLaunchStrategy();
      expect(strategy.supports(Uri.parse('sms:123')), isTrue);
      expect(strategy.supports(Uri.parse('mailto:test@example.com')), isFalse);
    });

    test('MailtoUrlLaunchStrategy supports mailto', () {
      final strategy = MailtoUrlLaunchStrategy();
      expect(strategy.supports(Uri.parse('mailto:test@example.com')), isTrue);
      expect(strategy.supports(Uri.parse('sms:123')), isFalse);
    });

    test('DefaultUrlLaunchStrategy supports anything', () {
      final strategy = DefaultUrlLaunchStrategy();
      expect(strategy.supports(Uri.parse('file:///tmp/a.txt')), isTrue);
      expect(strategy.supports(Uri.parse('unknown:abc')), isTrue);
    });
  });

  group('UrlLaunchStrategyFactory.resolve', () {
    test('resolve should return SmsUrlLaunchStrategy for sms URI', () {
      final factory = UrlLaunchStrategyFactory();
      final strategy = factory.resolve(Uri.parse('sms:123'));

      expect(strategy, isA<SmsUrlLaunchStrategy>());
    });

    test('resolve should return MailtoUrlLaunchStrategy for mailto URI', () {
      final factory = UrlLaunchStrategyFactory();
      final strategy = factory.resolve(Uri.parse('mailto:test@example.com'));

      expect(strategy, isA<MailtoUrlLaunchStrategy>());
    });

    test('resolve should return MapsUrlLaunchStrategy for google maps URI', () {
      final factory = UrlLaunchStrategyFactory();
      final strategy = factory.resolve(Uri.parse('https://google.com/maps?q=test'));

      expect(strategy, isA<MapsUrlLaunchStrategy>());
    });
  });
}

