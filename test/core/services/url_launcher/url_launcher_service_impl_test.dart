import 'package:bloc_clean_arch/core/services/url_launcher/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUrlLaunchStrategyFactory extends Mock implements UrlLaunchStrategyFactory {}
class MockUrlLaunchStrategy extends Mock implements UrlLaunchStrategy {}

void main() {
  late UrlLauncherServiceImpl service;
  late MockUrlLaunchStrategyFactory mockFactory;
  late MockUrlLaunchStrategy mockStrategy;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() {
    mockFactory = MockUrlLaunchStrategyFactory();
    mockStrategy = MockUrlLaunchStrategy();
    service = UrlLauncherServiceImpl(mockFactory);
  });

  group('UrlLauncherServiceImpl', () {
    test('launch should call factory.resolve and strategy.launch for web', () async {
      final uri = Uri.parse('https://example.com');
      when(() => mockFactory.resolve(any())).thenReturn(mockStrategy);
      when(() => mockStrategy.launch(any(), mode: any(named: 'mode'))).thenAnswer((_) async => true);

      final result = await service.launch('https://example.com', type: UrlType.web);

      expect(result, true);
      verify(() => mockFactory.resolve(uri)).called(1);
      verify(() => mockStrategy.launch(uri)).called(1);
    });

    test('launch should format tel URI correctly', () async {
      final uri = Uri.parse('tel:1234567890');
      when(() => mockFactory.resolve(any())).thenReturn(mockStrategy);
      when(() => mockStrategy.launch(any(), mode: any(named: 'mode'))).thenAnswer((_) async => true);

      await service.launch('1234567890', type: UrlType.tel);

      verify(() => mockFactory.resolve(uri)).called(1);
    });

    test('launch should format whatsapp URI correctly', () async {
      final uri = Uri.parse('https://wa.me/1234567890');
      when(() => mockFactory.resolve(any())).thenReturn(mockStrategy);
      when(() => mockStrategy.launch(any(), mode: any(named: 'mode'))).thenAnswer((_) async => true);

      await service.launch('123-456-7890', type: UrlType.whatsapp);

      verify(() => mockFactory.resolve(uri)).called(1);
    });
  });
}
