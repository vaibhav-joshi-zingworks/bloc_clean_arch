import 'package:bloc_clean_arch/gen/localization/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppLocalizations (generated)', () {
    test('AppLocalizationsEn provides expected English strings', () {
      final en = lookupAppLocalizations(const Locale('en'));

      expect(en.hello, 'Hello');
      expect(en.login, 'Login');
      expect(en.logout, 'Logout');
      expect(en.welcomeUser('Bob'), 'Welcome, Bob!');
    });

    test('delegate supports en and throws for unsupported locales', () {
      expect(AppLocalizations.supportedLocales, const [Locale('en')]);
      expect(AppLocalizations.delegate.isSupported(const Locale('en')), isTrue);
      expect(AppLocalizations.delegate.isSupported(const Locale('fr')), isFalse);

      expect(lookupAppLocalizations(const Locale('en')).hello, 'Hello');

      expect(
        () => lookupAppLocalizations(const Locale('fr')),
        throwsA(isA<FlutterError>()),
      );
    });

    testWidgets('Localizations + AppLocalizations.of(context) works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context)!;
              return Text(l10n.hello, textDirection: TextDirection.ltr);
            },
          ),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
    });
  });
}

