import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'vpn_checker_method_channel.dart';

abstract class VpnCheckerPlatform extends PlatformInterface {
  /// Constructs a VpnCheckerPlatform.
  VpnCheckerPlatform() : super(token: _token);

  static final Object _token = Object();

  static VpnCheckerPlatform _instance = MethodChannelVpnChecker();

  /// The default instance of [VpnCheckerPlatform] to use.
  ///
  /// Defaults to [MethodChannelVpnChecker].
  static VpnCheckerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VpnCheckerPlatform] when
  /// they register themselves.
  static set instance(VpnCheckerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isUseVpn() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
