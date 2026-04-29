import 'package:bloc_clean_arch/resources/theme/theme.dart';
import 'package:bloc_clean_arch/resources/theme/app_color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    test('light theme should have correct brightness and colors', () {
      final theme = AppTheme.light;

      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.primary, AppColorPalette.primary);
      expect(theme.scaffoldBackgroundColor, AppColorPalette.lightSurface);
    });

    test('dark theme should have correct brightness and colors', () {
      final theme = AppTheme.dark;

      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.primary, AppColorPalette.primary);
      expect(theme.scaffoldBackgroundColor, AppColorPalette.darkSurface);
    });

    test('themes should use Material 3', () {
      expect(AppTheme.light.useMaterial3, isTrue);
      expect(AppTheme.dark.useMaterial3, isTrue);
    });
  });
}
