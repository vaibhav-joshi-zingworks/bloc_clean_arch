import 'dart:async';

import 'package:bloc_clean_arch/app/providers/app_message.dart';
import 'package:bloc_clean_arch/app/providers/global_message_cubit.dart';
import 'package:bloc_clean_arch/app/providers/global_message_listener.dart';
import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGlobalMessageCubit extends Mock implements GlobalMessageCubit {}

void main() {
  late MockGlobalMessageCubit mockCubit;

  setUp(() {
    mockCubit = MockGlobalMessageCubit();

    if (sl.isRegistered<GlobalMessageCubit>()) {
      sl.unregister<GlobalMessageCubit>();
    }

    sl.registerSingleton<GlobalMessageCubit>(mockCubit);

    when(() => mockCubit.state).thenReturn(null);
    when(() => mockCubit.clear()).thenAnswer((_) async {});
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('GlobalMessageListener triggers snackbar when message is emitted', (tester) async {
    final controller = StreamController<AppMessage?>();

    when(() => mockCubit.stream).thenAnswer((_) => controller.stream);

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

    verify(() => mockCubit.clear()).called(1);

    await controller.close();
  });
}