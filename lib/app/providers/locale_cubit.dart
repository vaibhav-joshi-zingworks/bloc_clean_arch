import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit() : super(null); // ✅ null = system locale

  void setLocale(Locale? locale) {
    emit(locale);
  }

  void useSystemLocale() => emit(null);

  void setEnglish() => emit(const Locale('en'));
  void setArabic() => emit(const Locale('ar'));
}