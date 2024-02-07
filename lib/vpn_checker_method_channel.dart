import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'vpn_checker_platform_interface.dart';

/// An implementation of [VpnCheckerPlatform] that uses method channels.
class MethodChannelVpnChecker extends VpnCheckerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('vpn_checker');

  /// [isUseVpn]
  /// This method will to native to checking the device is using VPN or not.
  /// This method return bool
  @override
  Future<bool> isUseVpn() async {
    final isUseVpn = await methodChannel.invokeMethod<bool>('isUseVpn');
    return isUseVpn ?? true;
  }
}
