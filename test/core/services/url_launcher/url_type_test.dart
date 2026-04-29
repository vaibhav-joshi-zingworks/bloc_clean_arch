import 'package:bloc_clean_arch/core/services/url_launcher/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UrlType', () {
    test('should have expected values', () {
      expect(UrlType.values, contains(UrlType.web));
    });
  });
}
