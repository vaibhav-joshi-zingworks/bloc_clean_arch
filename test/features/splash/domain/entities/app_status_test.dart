import 'package:bloc_clean_arch/features/splash/domain/entities/app_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppStatus enum has expected values', () {
    expect(AppStatus.values.length, 3);
    expect(AppStatus.authenticated, isNotNull);
    expect(AppStatus.unauthenticated, isNotNull);
    expect(AppStatus.firstLaunch, isNotNull);
  });
}
