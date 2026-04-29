import 'package:bloc_clean_arch/app/providers/app_message.dart';
import 'package:bloc_clean_arch/app/providers/global_message_cubit.dart';
import 'package:bloc_clean_arch/utilities/enums/enums.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GlobalMessageCubit', () {
    late GlobalMessageCubit cubit;

    setUp(() {
      cubit = GlobalMessageCubit();
    });

    test('initial state is null', () {
      expect(cubit.state, isNull);
    });

    blocTest<GlobalMessageCubit, AppMessage?>(
      'emits AppMessage when showMessage is called',
      build: () => cubit,
      act: (cubit) => cubit.showMessage('Test', MessageType.success),
      expect: () => [
        isA<AppMessage>()
            .having((m) => m.message, 'message', 'Test')
            .having((m) => m.type, 'type', MessageType.success),
      ],
    );

    blocTest<GlobalMessageCubit, AppMessage?>(
      'emits null when clear is called',
      build: () => cubit,
      seed: () => AppMessage(message: 'Test', type: MessageType.success),
      act: (cubit) => cubit.clear(),
      expect: () => [isNull],
    );
  });
}
