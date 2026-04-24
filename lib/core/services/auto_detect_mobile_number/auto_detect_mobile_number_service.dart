import 'package:phone_number_hint/phone_number_hint.dart';

import '../../../core.dart';

class PhoneHintService {
  PhoneHintService._();

  static Future<String?> getPhoneNumber({String? countryCodeToRemove, int? maxLength}) async {
    if (!Platform.isAndroid) return null;

    try {
      final hint = PhoneNumberHint();

      final phoneNumber = await hint.requestHint();

      if (phoneNumber == null || phoneNumber.isEmpty) {
        return null;
      }

      String formatted = phoneNumber.replaceAll(RegExp(r'\D'), '');

      if (countryCodeToRemove != null && formatted.startsWith(countryCodeToRemove)) {
        formatted = formatted.substring(countryCodeToRemove.length);
      }

      if (maxLength != null && formatted.length > maxLength) {
        formatted = formatted.substring(formatted.length - maxLength);
      }

      return formatted;
    } on PlatformException catch (e) {
      debugPrint("PhoneHint PlatformException: ${e.message}");
      return null;
    } catch (e) {
      debugPrint("PhoneHint Unknown Error: $e");
      return null;
    }
  }
}
