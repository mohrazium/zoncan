part of 'settings.dart';

enum SettingsKeys {
  allSettings("all-settings"),
  appLocal("app-local"),
  fontScaleFactor("font-scale-factor"),
  unknown("unknown");

  final String key;
  const SettingsKeys(this.key);
}
