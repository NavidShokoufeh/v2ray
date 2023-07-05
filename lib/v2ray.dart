
import 'v2ray_platform_interface.dart';

class V2ray {
  Future<String?> getPlatformVersion() {
    return V2rayPlatform.instance.getPlatformVersion();
  }

  Future connect({required String vmessConnection}) async {
    
  }

  Future disConnects() async {
    
  }
}
