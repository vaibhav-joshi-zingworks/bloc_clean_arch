import 'package:bloc_clean_arch/utilities/widgets/app_circular_loader.dart';
import 'package:bloc_clean_arch/utilities/widgets/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppLoadingWidget renders AppCircularLoader', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AppLoadingWidget(),
      ),
    );

    expect(find.byType(AppCircularLoader), findsOneWidget);
  });

  testWidgets('AppLoadingWidget handles isInitialApi false', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppLoadingWidget(isInitialApi: true),
        ),
      ),
    );

    expect(find.byType(AbsorbPointer), findsOneWidget);
    expect(find.byType(AppCircularLoader), findsOneWidget);
  });
}
