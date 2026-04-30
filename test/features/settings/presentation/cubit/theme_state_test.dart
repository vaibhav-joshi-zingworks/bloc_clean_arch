import 'package:bloc_clean_arch/features/settings/presentation/cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeState', () {
    test('should support value equality', () {
      expect(
        const ThemeState(mode: ThemeMode.dark, isLoading: false),
        const ThemeState(mode: ThemeMode.dark, isLoading: false),
      );
    });

    test('copyWith should return updated object', () {
      const state = ThemeState(mode: ThemeMode.light,isLoading: false);
      final updated = state.copyWith(mode: ThemeMode.dark);
      expect(updated.mode, ThemeMode.dark);
    });
  });
}
