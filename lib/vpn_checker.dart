import 'vpn_checker_platform_interface.dart';

class VpnChecker {
  /// [isUseVpn]
  /// Call this method when we want to checking the device is using VPN or not.
  /// This method return bool
  ///
  Future<bool> isUseVpn() {
    return VpnCheckerPlatform.instance.isUseVpn();
  }
}
