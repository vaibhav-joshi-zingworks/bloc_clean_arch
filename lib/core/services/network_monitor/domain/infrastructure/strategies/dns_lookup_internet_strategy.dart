import 'dart:async';
import 'dart:io';

import '../../../xcore.dart';

/// Implementation of [InternetCheckStrategy] that uses DNS lookup to verify internet connectivity.
/// 
/// It attempts to resolve a well-known public host (like 1.1.1.1) to confirm 
/// that the network connection is functional.
class DnsLookupInternetStrategy implements InternetCheckStrategy {
  @override
  Future<bool> hasInternetAccess() async {
    try {
      // Perform a DNS lookup with a short timeout
      final result = await InternetAddress.lookup('one.one.one.one').timeout(const Duration(seconds: 2));

      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      // Usually indicates no route to host or network is down
      return false;
    } on TimeoutException {
      // Indicates the network is too slow or DNS is blocked
      return false;
    }
  }
}
