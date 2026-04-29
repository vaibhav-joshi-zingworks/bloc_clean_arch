import 'package:bloc_clean_arch/core/services/app_device_info/infrastructure/services/brightness_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBrightnessProvider extends Mock implements BrightnessProvider {}

void main() {
  group('BrightnessProvider', () {
    test('can be mocked', () {
      final provider = MockBrightnessProvider();
      expect(provider, isA<BrightnessProvider>());
    });
  });
}
