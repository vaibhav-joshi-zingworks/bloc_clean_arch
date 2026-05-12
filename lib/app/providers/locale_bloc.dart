import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object?> get props => [];
}

class LocaleChanged extends LocaleEvent {
  const LocaleChanged(this.locale);

  final Locale? locale;

  @override
  List<Object?> get props => [locale];
}

class SystemLocaleRequested extends LocaleEvent {
  const SystemLocaleRequested();
}

class EnglishLocaleRequested extends LocaleEvent {
  const EnglishLocaleRequested();
}

class ArabicLocaleRequested extends LocaleEvent {
  const ArabicLocaleRequested();
}

/// Bloc managing the application's [Locale].
class LocaleBloc extends Bloc<LocaleEvent, Locale?> {
  LocaleBloc() : super(null) {
    on<LocaleChanged>((event, emit) => emit(event.locale));
    on<SystemLocaleRequested>((event, emit) => emit(null));
    on<EnglishLocaleRequested>((event, emit) => emit(const Locale('en')));
    on<ArabicLocaleRequested>((event, emit) => emit(const Locale('ar')));
  }
}
