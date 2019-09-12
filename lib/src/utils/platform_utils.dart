import 'dart:io';

class PlatformUtils {
  static bool isMobileDevice() => Platform.isAndroid || Platform.isIOS;
}
