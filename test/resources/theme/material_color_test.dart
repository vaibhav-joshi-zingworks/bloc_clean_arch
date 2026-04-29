import 'package:bloc_clean_arch/resources/theme/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomMaterialColor', () {
    test('generate should create a MaterialColor with correct shades', () {
      const colorValue = 0xFF035C4D;
      final materialColor = CustomMaterialColor.generate(colorValue);

      expect(materialColor, isA<MaterialColor>());
      expect(materialColor.value, colorValue);
      expect(materialColor[50], const Color(colorValue));
      expect(materialColor[100], const Color(colorValue));
      expect(materialColor[200], const Color(colorValue));
      expect(materialColor[300], const Color(colorValue));
      expect(materialColor[400], const Color(colorValue));
      expect(materialColor[500], const Color(colorValue));
      expect(materialColor[600], const Color(colorValue));
      expect(materialColor[700], const Color(colorValue));
      expect(materialColor[800], const Color(colorValue));
      expect(materialColor[900], const Color(colorValue));
    });
  });
}
