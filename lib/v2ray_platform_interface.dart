import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'v2ray_method_channel.dart';

abstract class V2rayPlatform extends PlatformInterface {
  /// Constructs a V2rayPlatform.
  V2rayPlatform() : super(token: _token);

  static final Object _token = Object();

  static V2rayPlatform _instance = MethodChannelV2ray();

  /// The default instance of [V2rayPlatform] to use.
  ///
  /// Defaults to [MethodChannelV2ray].
  static V2rayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [V2rayPlatform] when
  /// they register themselves.
  static set instance(V2rayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
