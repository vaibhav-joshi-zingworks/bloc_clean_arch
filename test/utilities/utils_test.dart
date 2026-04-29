import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/utilities/enums/enums.dart';
import 'package:bloc_clean_arch/utilities/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Utils.getColor', () {
    test('should return red for error message type', () {
      expect(Utils.getColor(MessageType.error), AppColorPalette.red);
    });

    test('should return green for success message type', () {
      expect(Utils.getColor(MessageType.success), AppColorPalette.green);
    });

    test('should return primary color for general message type', () {
      expect(Utils.getColor(MessageType.general), AppColorPalette.primary);
    });
  });
}
