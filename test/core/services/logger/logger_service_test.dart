import 'package:bloc_clean_arch/core/services/logger/logger_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoggerService', () {
    test('static methods should be callable without crashing', () {
      // These methods return void and log to console/talker
      logInfo('Test info');
      logDebug('Test debug');
      logWarning('Test warning');
      logError('Test error');
    });
  });
}
