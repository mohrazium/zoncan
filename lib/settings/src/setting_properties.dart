part of zoncan.settings;

abstract class SettingProperties
    implements Built<SettingProperties, SettingPropertiesBuilder> {
  double get fontScale;
  String get locale;

  factory SettingProperties({
    double? fontScale,
    String? locale,
  }) =>
      SettingProperties.builder(
        (b) => b
          ..fontScale = fontScale ?? 1.0
          ..locale = locale ?? "fa",
      );

  factory SettingProperties.builder(
      [void Function(SettingPropertiesBuilder) updates]) = _$SettingProperties;

  SettingProperties._();

  factory SettingProperties.init() => SettingProperties();

  static Serializer<SettingProperties> get serializer => _$settingPropertiesSerializer;

  String toJson() => json.encode(ModelSerializer.standardSerializers
      .serializeWith(SettingProperties.serializer, this));

  factory SettingProperties.fromJson(String jsonString) =>
      ModelSerializer.standardSerializers.deserializeWith(
          SettingProperties.serializer, json.decode(jsonString)) ??
      _$SettingProperties();
}
