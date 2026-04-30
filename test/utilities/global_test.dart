import 'package:bloc_clean_arch/utilities/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Global', () {
    test('navigatorKey should be a GlobalKey<NavigatorState>', () {
      expect(Global.navigatorKey, isA<GlobalKey<NavigatorState>>());
    });

    test('scaffoldMessengerKey should be a GlobalKey<ScaffoldMessengerState>', () {
      expect(Global.scaffoldMessengerKey, isA<GlobalKey<ScaffoldMessengerState>>());
    });
  });
}
