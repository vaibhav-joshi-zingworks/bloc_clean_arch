import 'package:bloc_clean_arch/utilities/extensions/extentions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CapitalizeFirst', () {
    test('should capitalize first letter', () {
      expect('hello'.capitalizeFirst, 'Hello');
    });

    test('should return empty string for empty input', () {
      expect(''.capitalizeFirst, '');
    });
  });

  group('DateTimeExtensions', () {
    test('dateOnly should return only the date part', () {
      final date = DateTime(2023, 10, 15, 12, 30);
      expect(date.dateOnly, '2023-10-15');
    });
  });
}
