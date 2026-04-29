import 'package:bloc_clean_arch/core/services/url_launcher/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUrlLaunchStrategy extends Mock implements UrlLaunchStrategy {}

void main() {
  group('UrlLaunchStrategy', () {
    test('can be mocked', () {
      final strategy = MockUrlLaunchStrategy();
      expect(strategy, isA<UrlLaunchStrategy>());
    });
  });
}
