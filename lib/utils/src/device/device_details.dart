part of zoncan.utils.device;

class DeviceInfo {
  static bool isDesktop() {
    return Platform.isLinux || Platform.isWindows || Platform.isMacOS;
  }
}
