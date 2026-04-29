import 'package:bloc_clean_arch/core/network/use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('NoParams should be instantiable', () {
    final params = NoParams();
    expect(params, isA<NoParams>());
  });
}
