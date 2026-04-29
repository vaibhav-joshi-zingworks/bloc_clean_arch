import 'dart:ui';
import 'package:bloc_clean_arch/app/providers/locale_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocaleCubit', () {
    late LocaleCubit cubit;

    setUp(() {
      cubit = LocaleCubit();
    });

    test('initial state is null', () {
      expect(cubit.state, isNull);
    });

    blocTest<LocaleCubit, Locale?>(
      'emits correct locale when setLocale is called',
      build: () => cubit,
      act: (cubit) => cubit.setLocale(const Locale('fr')),
      expect: () => [const Locale('fr')],
    );

    blocTest<LocaleCubit, Locale?>(
      'emits English locale when setEnglish is called',
      build: () => cubit,
      act: (cubit) => cubit.setEnglish(),
      expect: () => [const Locale('en')],
    );
  });
}
