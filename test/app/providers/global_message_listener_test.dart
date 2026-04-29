import 'package:bloc_clean_arch/app/providers/app_message.dart';
import 'package:bloc_clean_arch/app/providers/global_message_cubit.dart';
import 'package:bloc_clean_arch/app/providers/global_message_listener.dart';
import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/utilities/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGlobalMessageCubit extends Mock implements GlobalMessageCubit {}

void main() {
  late MockGlobalMessageCubit mockCubit;

  setUp(() {
    mockCubit = MockGlobalMessageCubit();
    // Register in GetIt (sl)
    if (sl.isRegistered<GlobalMessageCubit>()) {
      sl.unregister<GlobalMessageCubit>();
    }
    sl.registerSingleton<GlobalMessageCubit>(mockCubit);

    when(() => mockCubit.state).thenReturn(null);
    when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockCubit.clear()).thenReturn(null);
  });

  tearDown(() {
    sl.reset();
  });

  testWidgets('GlobalMessageListener triggers snackbar when message is emitted', (tester) async {
    final messageStream = StreamController<AppMessage?>.broadcast();
    when(() => mockCubit.stream).thenAnswer((_) => messageStream.stream);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GlobalMessageListener(
            child: Container(),
          ),
        ),
      ),
    );

    // Emit message
    messageStream.add(AppMessage(message: 'Success Message', type: MessageType.success));
    await tester.pump(); // Start listener
    await tester.pump(); // Show Snackbar

    // Verify snackbar is shown (Utils.snackBar is called)
    // Since Utils.snackBar uses Global.scaffoldMessengerKey, we can check if it's there.
    expect(find.text('Success Message'), findsOneWidget);
    verify(() => mockCubit.clear()).called(1);
    
    await messageStream.close();
  });
}
