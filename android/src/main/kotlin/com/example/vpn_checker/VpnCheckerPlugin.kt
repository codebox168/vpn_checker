package com.codebox168.vpn_checker

import androidx.annotation.NonNull
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities

/** VpnCheckerPlugin */
class VpnCheckerPlugin: FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    private lateinit var channel: MethodChannel

    /// ConnectivityManager instance for network checks
    private lateinit var connectivityManager: ConnectivityManager

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "vpn_checker")
        channel.setMethodCallHandler(this)

        // Get ConnectivityManager instance from the application context
        connectivityManager = flutterPluginBinding.applicationContext.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "isUseVpn") {
            val activeNetwork = connectivityManager.activeNetwork ?: run {
                result.error("404", "No active network found", null)
                return
            }
            val caps = connectivityManager.getNetworkCapabilities(activeNetwork) ?: run {
                result.error("404", "Network capabilities not available", null)
                return
            }
            val isUseVpn = caps.hasTransport(NetworkCapabilities.TRANSPORT_VPN)
            result.success(isUseVpn)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
