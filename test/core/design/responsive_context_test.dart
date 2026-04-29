import 'package:bloc_clean_arch/core/design/app_breakpoints.dart';
import 'package:bloc_clean_arch/core/design/device_type.dart';
import 'package:bloc_clean_arch/core/design/responsive_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ResponsiveContext extension tests', (tester) async {
    late BuildContext capturedContext;

    // Test Mobile
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(size: Size(AppBreakpoints.mobile - 1, 800)),
          child: Builder(builder: (context) {
            capturedContext = context;
            return const Placeholder();
          }),
        ),
      ),
    );

    expect(capturedContext.isMobile, true);
    expect(capturedContext.deviceType, DeviceType.mobile);

    // Test Tablet
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(size: Size(AppBreakpoints.mobile + 1, 800)),
          child: Builder(builder: (context) {
            capturedContext = context;
            return const Placeholder();
          }),
        ),
      ),
    );

    expect(capturedContext.isTablet, true);
    expect(capturedContext.deviceType, DeviceType.tablet);
  });
}
