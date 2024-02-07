import 'package:flutter_test/flutter_test.dart';
import 'package:vpn_checker/vpn_checker.dart';
import 'package:vpn_checker/vpn_checker_platform_interface.dart';
import 'package:vpn_checker/vpn_checker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVpnCheckerPlatform
    with MockPlatformInterfaceMixin
    implements VpnCheckerPlatform {
  @override
  Future<bool> isUseVpn() {
    return Future(() => true);
  }
}

void main() {
  final VpnCheckerPlatform initialPlatform = VpnCheckerPlatform.instance;

  test('$MethodChannelVpnChecker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVpnChecker>());
  });

  test('isUseVPN', () async {
    VpnChecker vpnCheckerPlugin = VpnChecker();
    MockVpnCheckerPlatform fakePlatform = MockVpnCheckerPlatform();
    VpnCheckerPlatform.instance = fakePlatform;

    expect(await vpnCheckerPlugin.isUseVpn(), true);
  });
}
