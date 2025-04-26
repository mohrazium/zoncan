

import 'package:dart_mappable/dart_mappable.dart';
part 'setting_properties.mapper.dart';

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
