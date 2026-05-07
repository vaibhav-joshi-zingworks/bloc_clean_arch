import 'package:phone_number_hint/phone_number_hint.dart';

import '../../../core.dart';

/// Service that leverages Android's Phone Number Hint API to auto-fill mobile numbers.
/// 
/// This simplifies the onboarding flow by allowing users to select a SIM-linked 
/// phone number without manual typing.
class PhoneHintService {
  PhoneHintService._();

  /// Triggers the system UI to request a phone number hint from the device.
  /// 
  /// Currently only supported on [Platform.isAndroid].
  /// [countryCodeToRemove] can be used to strip prefixes like '91'.
  /// [maxLength] can be used to trim the number to a specific length (e.g. 10 digits).
  static Future<String?> getPhoneNumber({String? countryCodeToRemove, int? maxLength}) async {
    if (!Platform.isAndroid) return null;

    try {
      final hint = PhoneNumberHint();

      // Invoke the native dialog
      final phoneNumber = await hint.requestHint();

      if (phoneNumber == null || phoneNumber.isEmpty) {
        return null;
      }

      // Remove non-digit characters
      String formatted = phoneNumber.replaceAll(RegExp(r'\D'), '');

      // Optional: Strip country code
      if (countryCodeToRemove != null && formatted.startsWith(countryCodeToRemove)) {
        formatted = formatted.substring(countryCodeToRemove.length);
      }

      // Optional: Enforce max length (taking from the end)
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
