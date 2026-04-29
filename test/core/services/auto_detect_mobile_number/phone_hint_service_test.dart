import 'package:bloc_clean_arch/core/services/auto_detect_mobile_number/auto_detect_mobile_number_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhoneHintService', () {
    test('getPhoneNumber should return null on non-android platforms', () async {
      // In tests, Platform.isAndroid might be false depending on host
      // This is a simple verification of the platform check logic
      if (!isAndroid) {
        final result = await PhoneHintService.getPhoneNumber();
        expect(result, isNull);
      }
    });
  });
}

bool get isAndroid => false; // Helper for test mock if needed
