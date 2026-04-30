import 'package:bloc_clean_arch/app/bootstrap/app_initializer_cubit.dart';
import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsFacade extends Mock implements AnalyticsFacade {}
class MockNotificationStrategy extends Mock implements NotificationStrategy {}

void main() {
  late AppInitializerCubit cubit;
  late MockAnalyticsFacade mockAnalytics;
  late MockNotificationStrategy mockNotificationStrategy;

  setUp(() {
    mockAnalytics = MockAnalyticsFacade();
    mockNotificationStrategy = MockNotificationStrategy();
    cubit = AppInitializerCubit(
      analytics: mockAnalytics,
      notificationStrategy: mockNotificationStrategy,
    );
  });

  test('initialize should call notification strategy initialize', () async {
    // arrange
    when(() => mockNotificationStrategy.initialize()).thenAnswer((_) async => {});
    // act
    await cubit.initialize();
    // assert
    verify(() => mockNotificationStrategy.initialize()).called(1);
  });
}
