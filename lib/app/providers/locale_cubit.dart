import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit managing the application's [Locale].
/// 
/// Emitting `null` signals the app to fallback to the device's system locale.
class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit() : super(null); // Initialize with system default

  /// Updates the current locale manually.
  void setLocale(Locale? locale) {
    emit(locale);
  }

  /// Reset the app to follow the device's system language.
  void useSystemLocale() => emit(null);

  /// Helper to switch to English language.
  void setEnglish() => emit(const Locale('en'));

  /// Helper to switch to Arabic language.
  void setArabic() => emit(const Locale('ar'));
}
