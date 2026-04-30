import 'package:bloc_clean_arch/utilities/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppTextWidget renders correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppTextWidget(text: 'Hello'),
        ),
      ),
    );

    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('AppTextWidget handles onTap', (tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppTextWidget(
            text: 'Click me',
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Click me'));
    expect(tapped, true);
  });
}
