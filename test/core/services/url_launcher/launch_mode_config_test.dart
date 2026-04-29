import 'package:bloc_clean_arch/core/services/url_launcher/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LaunchModeConfig', () {
    test('should return externalApplication as default', () {
      expect(LaunchModeConfig.defaultMode, LaunchMode.externalApplication);
    });
  });
}
