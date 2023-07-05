import 'package:flutter_test/flutter_test.dart';
import 'package:v2ray/v2ray.dart';
import 'package:v2ray/v2ray_platform_interface.dart';
import 'package:v2ray/v2ray_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockV2rayPlatform
    with MockPlatformInterfaceMixin
    implements V2rayPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final V2rayPlatform initialPlatform = V2rayPlatform.instance;

  test('$MethodChannelV2ray is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelV2ray>());
  });

  test('getPlatformVersion', () async {
    V2ray v2rayPlugin = V2ray();
    MockV2rayPlatform fakePlatform = MockV2rayPlatform();
    V2rayPlatform.instance = fakePlatform;

    expect(await v2rayPlugin.getPlatformVersion(), '42');
  });
}
