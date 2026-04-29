import 'package:bloc_clean_arch/resources/theme/app_color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColorPalette', () {
    test('primary color should be correct', () {
      expect(AppColorPalette.primary, const Color(0xFF035C4D));
    });

    test('black color should be correct', () {
      expect(AppColorPalette.black, Colors.black);
    });

    test('white color should be correct', () {
      expect(AppColorPalette.white, Colors.white);
    });

    test('darkSurface color should be correct', () {
      expect(AppColorPalette.darkSurface, const Color(0xFF1C1B1F));
    });

    test('lightSurface color should be correct', () {
      expect(AppColorPalette.lightSurface, const Color(0xFFF4F8F7));
    });

    test('grey color should be correct', () {
      expect(AppColorPalette.grey, const Color(0xFF808080));
    });

    test('lightGrey color should be correct', () {
      expect(AppColorPalette.lightGrey, const Color(0xFFCDCDCD));
    });

    test('darkGrey color should be correct', () {
      expect(AppColorPalette.darkGrey, const Color(0xFF3A3A3A));
    });

    test('red color should be correct', () {
      expect(AppColorPalette.red, const Color(0xFFDD5050));
    });

    test('green color should be correct', () {
      expect(AppColorPalette.green, const Color(0xFF27AA1A));
    });

    test('blue color should be correct', () {
      expect(AppColorPalette.blue, const Color(0xFF2381C4));
    });
  });
}
