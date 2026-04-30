import 'package:bloc_clean_arch/core/failure/app_exception.dart';
import 'package:bloc_clean_arch/utilities/widgets/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppErrorWidget renders exception message', (tester) async {
    final exception = AppException(500, 'Something went wrong');
    await tester.pumpWidget(
      MaterialApp(
        home: AppErrorWidget(exception: exception),
      ),
    );

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('AppErrorWidget triggers retry callback', (tester) async {
    bool retryCalled = false;
    final exception = AppException(500, 'Error');
    await tester.pumpWidget(
      MaterialApp(
        home: AppErrorWidget(
          exception: exception,
          retry: () => retryCalled = true,
        ),
      ),
    );

    await tester.tap(find.text('Retry'));
    expect(retryCalled, true);
  });
}
