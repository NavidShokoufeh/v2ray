import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'v2ray_platform_interface.dart';

/// An implementation of [V2rayPlatform] that uses method channels.
class MethodChannelV2ray extends V2rayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  static const methodChannel =  MethodChannel('v2ray');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  static get connect async {
    await methodChannel.invokeMethod('connect');
  }

  
  
}
