import 'package:bloc_clean_arch/resources/constants/url_end_points.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UrlEndPoints', () {
    test('should be instantiable', () {
      final urlEndPoints = UrlEndPoints();
      expect(urlEndPoints, isA<UrlEndPoints>());
    });
  });
}
