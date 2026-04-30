import 'package:bloc_clean_arch/core/services/network_monitor/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late ConnectivityPlusAdapter adapter;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    adapter = ConnectivityPlusAdapter(mockConnectivity);
  });

  group('ConnectivityPlusAdapter', () {
    test('checkConnectivity should call connectivity.checkConnectivity', () async {
      when(() => mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.wifi]);
      final result = await adapter.checkConnectivity();
      expect(result, [ConnectivityResult.wifi]);
      verify(() => mockConnectivity.checkConnectivity()).called(1);
    });
  });
}
