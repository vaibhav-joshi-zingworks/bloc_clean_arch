import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeMode mode;
  final bool isLoading;

  const ThemeState({
    required this.mode,
    required this.isLoading,
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

  @override
  List<Object?> get props => [mode, isLoading]; // 🔥 IMPORTANT
}