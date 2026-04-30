import 'package:bloc_clean_arch/utilities/widgets/app_circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppCircularLoader renders correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppCircularLoader(size: 30),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    final SizedBox sizedBox = tester.widget(find.byType(SizedBox));
    expect(sizedBox.width, 30);
    expect(sizedBox.height, 30);
  });
}
