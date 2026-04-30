import 'package:bloc_clean_arch/utilities/widgets/app_loading.dart';
import 'package:bloc_clean_arch/utilities/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppScaffold renders body', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AppScaffold(
          body: Text('Main Content'),
        ),
      ),
    );

    expect(find.text('Main Content'), findsOneWidget);
  });

  testWidgets('AppScaffold shows overlay loader', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AppScaffold(
          body: SizedBox(),
          isOverlayLoader: true,
        ),
      ),
    );

    expect(find.byType(AppLoadingWidget), findsOneWidget);
  });

  testWidgets('AppScaffold shows bottom navigation bar', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AppScaffold(
          body: Text('Body'),
          bottomNavigationBar: Text('BottomNav'),
        ),
      ),
    );

    expect(find.text('BottomNav'), findsOneWidget);
  });

  testWidgets('AppScaffold supports refresh', (tester) async {
    bool refreshed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: AppScaffold(
          body: ListView(children: const [Text('Item')]),
          onRefresh: () async {
            refreshed = true;
          },
        ),
      ),
    );

    await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
    await tester.pumpAndSettle();

    expect(refreshed, true);
  });
}