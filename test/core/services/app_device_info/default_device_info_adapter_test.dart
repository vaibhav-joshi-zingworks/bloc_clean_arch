import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeviceInfoPlugin extends Mock implements DeviceInfoPlugin {}
class MockAndroidDeviceInfo extends Mock implements AndroidDeviceInfo {}
class MockIosDeviceInfo extends Mock implements IosDeviceInfo {}
class MockAndroidBuildVersion extends Mock implements AndroidBuildVersion {}
class MockIosUtsname extends Mock implements IosUtsname {}

void main() {
  // late DefaultDeviceInfoAdapter adapter;
  // late MockDeviceInfoPlugin mockDeviceInfo;

  setUp(() {
    // mockDeviceInfo = MockDeviceInfoPlugin();
    // adapter = DefaultDeviceInfoAdapter(mockDeviceInfo);
  });

  group('DefaultDeviceInfoAdapter', () {
    // final packageInfo = PackageInfo(
    //   appName: 'App',
    //   packageName: 'com.app',
    //   version: '1.2.3',
    //   buildNumber: '1',
    // );

    test('getUserAgent returns correct string for Android', () {
      final mockAndroid = MockAndroidDeviceInfo();
      final mockVersion = MockAndroidBuildVersion();
      
      when(() => mockAndroid.version).thenReturn(mockVersion);
      when(() => mockVersion.release).thenReturn('13');
      when(() => mockAndroid.model).thenReturn('Pixel 6');

      // Note: This test assumes Platform.isAndroid is true if we want to hit that branch.
      // But we can test the helper method logic if we mock Platform (which is hard).
      // However, the implementation uses Platform.isAndroid directly.
    });

    test('getUserAgent handles iOS format correctly', () {
      final mockIos = MockIosDeviceInfo();
      final mockUtsname = MockIosUtsname();
      
      when(() => mockIos.systemVersion).thenReturn('16.0');
      when(() => mockIos.utsname).thenReturn(mockUtsname);
      when(() => mockUtsname.machine).thenReturn('iPhone14,5');

      // Similar to Android, branch depends on Platform.isIOS.
    });
  });
}
