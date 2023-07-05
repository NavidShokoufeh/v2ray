package com.example.v2ray;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.v2ray.core.V2Ray;
import io.v2ray.core.common.SerializedInstance;
import io.v2ray.core.common.V2RayException;
import io.v2ray.core.proxy.vmess.*;
import io.v2ray.core.transport.TransportProtocol;
import io.v2ray.core.transport.internet.DomainSocketAddress;
import io.v2ray.core.transport.internet.TcpTransportConfig;
import io.v2ray.core.transport.internet.TransportConfig;


/** V2rayPlugin */
public class V2rayPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "v2ray");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if(call.method.equals("connect")){
      // VMessConnection();
      String vmessId = call.argument("id");
      String vmessAlterId = call.argument("altId");
      String vmessAddress = call.argument("address");
      String vmessPort = call.argument("port");

      try {
            // V2Ray configuration
            TransportConfig tcpConfig = TcpTransportConfig.newBuilder()
                    .setTransportProtocol(TransportProtocol.TCP)
                    .build();

            TransportConfig[] transportConfigs = { tcpConfig };

            // VMess account
            Account vmessAccount = Account.newBuilder()
                    .setId(vmessId)
                    .setAlterId(vmessAlterId)
                    .setSecuritySettings(SecurityConfig.getDefaultInstance())
                    .build();

            // VMess outbound handler
            OutboundHandler outboundHandler = new OutboundHandler(
                    new SerializedInstance<>(transportConfigs),
                    vmessAccount
            );

            // V2Ray configuration
            VMessProxyConfig vmessProxyConfig = VMessProxyConfig.newBuilder()
                    .setOutboundConfig(outboundHandler)
                    .build();

            // Listen options
            ListenOptions listenOptions = ListenOptions.newBuilder()
                    .addAddress(DomainSocketAddress.newBuilder()
                            .setAddress(vmessAddress)
                            .setPort(vmessPort)
                            .build())
                    .build();

            // Start V2Ray
            V2Ray.init(vmessProxyConfig, listenOptions);
            V2Ray.start();

            
            
        } catch (V2RayException e) {
            e.printStackTrace();
        }
    } 
    
    else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}