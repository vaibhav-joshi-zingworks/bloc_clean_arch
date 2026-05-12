import 'dart:async';

import 'package:bloc_clean_arch/app/providers/global_message.dart';
import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGlobalMessageBloc extends Mock implements GlobalMessageBloc {}

void main() {
  late MockGlobalMessageBloc mockBloc;

  setUp(() {
    mockBloc = MockGlobalMessageBloc();

    if (sl.isRegistered<GlobalMessageBloc>()) {
      sl.unregister<GlobalMessageBloc>();
    }

    sl.registerSingleton<GlobalMessageBloc>(mockBloc);

    when(() => mockBloc.state).thenReturn(null);
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('GlobalMessageListener triggers snackbar when message is emitted',
      (tester) async {
    final controller = StreamController<AppMessage?>();

    when(() => mockBloc.stream).thenAnswer((_) => controller.stream);

    await tester.pumpWidget(
      MaterialApp(
        scaffoldMessengerKey: Global.scaffoldMessengerKey, // 🔥 IMPORTANT
        home: Scaffold(
          body: GlobalMessageListener(
            child: Container(),
          ),
        ),
      ),
    );

    // Emit message
    controller.add(
      AppMessage(
        message: 'Success Message',
        type: MessageType.success,
      ),
    );

    // Let stream propagate + snackbar render
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // 🔥 IMPORTANT

    expect(find.text('Success Message'), findsOneWidget);

    verify(() => mockBloc.add(const GlobalMessageCleared())).called(1);

    await controller.close();
  });
}
