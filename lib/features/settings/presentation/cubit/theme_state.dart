import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Represents the current state of the application's theme.
class ThemeState extends Equatable {
  /// The selected theme mode (light, dark, or system).
  final ThemeMode mode;
  
  /// Indicates if the theme is currently being loaded from storage.
  final bool isLoading;

  const ThemeState({
    required this.mode,
    required this.isLoading,
  });

  /// Creates a copy of this state with the given fields replaced by the new values.
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
  List<Object?> get props => [mode, isLoading];
}