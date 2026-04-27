import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode mode;
  final bool isLoading;

  const ThemeState({
    required this.mode,
    this.isLoading = false,
  });

  ThemeState copyWith({
    ThemeMode? mode,
    bool? isLoading,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
