part of 'settings.dart';

@MappableClass(
    generateMethods: GenerateMethods.copy |
        GenerateMethods.equals |
        GenerateMethods.stringify |
        GenerateMethods.decode |
        GenerateMethods.encode)
class SettingProperties with SettingPropertiesMappable {
  double? fontScale;
  String? locale;

  SettingProperties({
    this.fontScale,
    this.locale,
  });

  factory SettingProperties.init() => SettingProperties();
}
