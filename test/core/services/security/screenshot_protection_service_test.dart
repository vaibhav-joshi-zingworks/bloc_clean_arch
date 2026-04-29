import 'package:bloc_clean_arch/core/services/security/screenshot_screenrecording_protection_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScreenshotScreenRecordingProtectionService', () {
    late ScreenshotScreenRecordingProtectionService service;

    setUp(() {
      service = ScreenshotScreenRecordingProtectionService();
    });

    test('initial state is not protected', () {
      expect(service.isProtected, false);
    });

    test('isRecording returns false on non-iOS platforms in test environment', () async {
      final recording = await service.isRecording();
      expect(recording, false);
    });
  });
}
