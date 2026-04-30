import 'package:bloc_clean_arch/utilities/widgets/view_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ViewState', () {
    test('Loading should be instantiable', () {
      expect(const Loading<int>(), isA<ViewState<int>>());
    });

    test('Error should hold error object', () {
      final error = Exception('error');
      final state = Error<int>(error);
      expect(state.error, error);
    });

    test('Data should hold data value', () {
      final state = const Data<int>(42);
      expect(state.value, 42);
    });
  });
}
