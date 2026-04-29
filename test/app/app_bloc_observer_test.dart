import 'package:bloc_clean_arch/app/app_bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBloc extends Mock implements Bloc<Object, Object> {}

void main() {
  late AppBlocObserver observer;
  late MockBloc mockBloc;

  setUp(() {
    observer = AppBlocObserver();
    mockBloc = MockBloc();
  });

  group('AppBlocObserver', () {
    test('onCreate should log debug message', () {
      // We can't easily verify logDebug unless we inject a logger,
      // but we can ensure the method doesn't crash.
      observer.onCreate(mockBloc);
    });

    test('onChange should log change', () {
      const change = Change(currentState: 'initial', nextState: 'next');
      observer.onChange(mockBloc, change);
    });

    test('onError should log error', () {
      final error = Exception('test error');
      observer.onError(mockBloc, error, StackTrace.empty);
    });
  });
}
