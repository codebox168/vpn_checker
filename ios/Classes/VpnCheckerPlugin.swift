import Flutter
import UIKit

public class VpnCheckerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "vpn_checker", binaryMessenger: registrar.messenger())
    let instance = VpnCheckerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "isUseVpn":
      if let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? Dictionary<String, Any>,
        let scopes = settings["__SCOPED__"] as? [String:Any] {
          for (key, _) in scopes {
          if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") {
                  result(true)
              }
          }
        }
        result(false)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
