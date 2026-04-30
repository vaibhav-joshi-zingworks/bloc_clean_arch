import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppBarWidget renders title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: AppBarWidget(title: 'My Title'),
        ),
      ),
    );

    expect(find.text('My Title'), findsOneWidget);
  });

  testWidgets('AppBarWidget shows back button by default', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: AppBarWidget(title: 'Test'),
        ),
      ),
    );

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('AppBarWidget hides back button when disabled', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: AppBarWidget(
            title: 'Test',
            showBackButton: false,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.arrow_back), findsNothing);
  });

  testWidgets('AppBarWidget triggers onBack callback', (tester) async {
    bool called = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBarWidget(
            title: 'Test',
            onBack: () => called = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.arrow_back));
    expect(called, true);
  });

  testWidgets('AppBarWidget renders actions', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: AppBarWidget(
            title: 'Test',
            actions: [Icon(Icons.settings)],
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.settings), findsOneWidget);
  });
}