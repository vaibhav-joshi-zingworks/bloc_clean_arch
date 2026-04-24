import 'dart:async';
import 'dart:io';

import '../../../xcore.dart';

class DnsLookupInternetStrategy implements InternetCheckStrategy {
  @override
  Future<bool> hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('one.one.one.one').timeout(const Duration(seconds: 2));

      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    }
  }
}
