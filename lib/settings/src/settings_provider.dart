part of zoncan.settings;

abstract class SettingsProvider {
  Future<SettingProperties> loadSettings();
  Future<SettingProperties> saveLocale(String rawLocale);
  Future<SettingProperties> saveFontScaleFactor(double scaleFactor);
}

class SettingsProviderImpl extends SettingsProvider {
  final StorageProvider _storage;

  SettingsProviderImpl(this._storage);

  @override
  Future<SettingProperties> loadSettings() async {
    final settings = await _storage.read(SettingsKeys.allSettings.key);
    if (settings == null) {
      final savedSettings = await _storage.write(SettingsKeys.allSettings.key,
          SettingProperties.init().toJson().toString());

      if (savedSettings) {
        return SettingProperties.fromJson(
            await _storage.read(SettingsKeys.allSettings.key));
      }
    }
    return SettingProperties.fromJson(settings);
  }

  @override
  Future<SettingProperties> saveFontScaleFactor(double scaleFactor) async {
    SettingProperties saveProperties = await loadSettings();
    saveProperties =
        saveProperties.rebuild((rb) => rb..fontScale = scaleFactor);
    _storage.write(
        SettingsKeys.allSettings.key, saveProperties.toJson().toString());
    return loadSettings();
  }

  @override
  Future<SettingProperties> saveLocale(String rawLocale) async {
    SettingProperties saveProperties = await loadSettings();
    saveProperties = saveProperties.rebuild((rb) => rb..locale = rawLocale);
    _storage.write(
        SettingsKeys.allSettings.key, saveProperties.toJson().toString());
    return loadSettings();
  }
}
