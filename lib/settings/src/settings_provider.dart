import 'package:zoncan/common/common.dart' show StorageProvider;

import 'setting_keys.dart';

abstract class SettingsProvider {
  Future<bool> saveLocalSettings(String rawLocal);
  Future<String> getLocalSettings();
}

class SettingsProviderImpl extends SettingsProvider {
  final StorageProvider _storage;

  SettingsProviderImpl(this._storage);

  @override
  Future<String> getLocalSettings() async {
    var f = await _storage.read(SettingsKeys.appLocal.key);
    print(f);
    return f.toString();
  }

  @override
  Future<bool> saveLocalSettings(String rawLocal) async {
    return await _storage.write(SettingsKeys.appLocal.key, rawLocal);
  }
}
