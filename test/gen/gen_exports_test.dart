import 'package:bloc_clean_arch/gen/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Gen exports', () {
    test('FontFamily contains expected font', () {
      expect(FontFamily.flink, 'Flink');
    });

    test('FlavorExtension.fromString parses dev/prod and rejects others', () {
      expect(FlavorExtension.fromString('dev'), Flavor.dev);
      expect(FlavorExtension.fromString('prod'), Flavor.prod);

      expect(
        () => FlavorExtension.fromString('staging'),
        throwsA(isA<Exception>()),
      );
    });

    test('Env getters are accessible (compile-time values may be empty)', () {
      expect(Env.host, isA<String>());
      expect(Env.baseUrl, isA<String>());
      expect(Env.imageBaseUrl, isA<String>());
      expect(Env.appEncryptionKey, isA<String>());
    });
  });
}

