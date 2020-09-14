import 'dart:io';

import 'package:device_info/device_info.dart';

class PlatformUtils {
  static Future<bool> isAndroidSdkLowerThan(int sdkVersion) async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      if (sdkInt < sdkVersion) {
        return true;
      }
    }

    return false;
  }
}