import 'dart:io';

import 'network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<String?> getLocalIp() async {
    final interfaces = await NetworkInterface.list(
      includeLoopback: false,
      type: InternetAddressType.IPv4,
    );

    for (final interface in interfaces) {
      for (final address in interface.addresses) {
        if (!address.isLoopback) {
          return address.address;
        }
      }
    }

    return null;
  }
}
