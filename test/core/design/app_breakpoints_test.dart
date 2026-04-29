import 'package:bloc_clean_arch/core/design/app_breakpoints.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppBreakpoints should have expected values', () {
    expect(AppBreakpoints.mobile, 600);
    expect(AppBreakpoints.tablet, 1024);
  });
}
