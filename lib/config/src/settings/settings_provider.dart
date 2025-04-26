
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/common/common.dart';

import 'setting_keys.dart';
import 'setting_properties.dart';


abstract class SettingsProvider {
  Future<SettingProperties> loadSettings();

  Future<SettingProperties> saveLocale(String rawLocale);

  Future<SettingProperties> saveFontScaleFactor(double scaleFactor);
}

@Injectable(as: SettingsProvider)
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
        return SettingPropertiesMapper.fromJson(
            await _storage.read(SettingsKeys.allSettings.key));
      }
    }
    return SettingPropertiesMapper.fromJson(settings);
  }

  @override
  Future<SettingProperties> saveFontScaleFactor(double scaleFactor) async {
    SettingProperties saveProperties = await loadSettings();
    saveProperties = saveProperties.copyWith(fontScale: scaleFactor);
    _storage.write(
        SettingsKeys.allSettings.key, saveProperties.toJson().toString());
    return loadSettings();
  }

  @override
  Future<SettingProperties> saveLocale(String rawLocale) async {
    SettingProperties saveProperties = await loadSettings();
    saveProperties = saveProperties.copyWith(locale: rawLocale);
    _storage.write(
        SettingsKeys.allSettings.key, saveProperties.toJson().toString());
    return loadSettings();
  }
}
