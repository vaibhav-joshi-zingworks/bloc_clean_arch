import 'package:bloc_clean_arch/core/services/url_launcher/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterUrlLauncherAdapter', () {
    test('should be instantiable', () {
      const adapter = FlutterUrlLauncherAdapter();
      expect(adapter, isA<FlutterUrlLauncherAdapter>());
    });
  });
}
