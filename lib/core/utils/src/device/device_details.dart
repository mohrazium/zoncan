part of '../../utils.dart';

class DeviceInfo {
  static bool isDesktop() {
    return Platform.isLinux || Platform.isWindows || Platform.isMacOS;
  }
}
