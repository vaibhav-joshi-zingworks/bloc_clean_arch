import 'package:bloc_clean_arch/core/services/url_launcher/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUrlLauncherService extends Mock implements UrlLauncherService {}

void main() {
  group('UrlLauncherService', () {
    test('can be mocked', () {
      final service = MockUrlLauncherService();
      expect(service, isA<UrlLauncherService>());
    });
  });
}
