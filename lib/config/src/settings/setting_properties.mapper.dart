// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'setting_properties.dart';

class SettingPropertiesMapper extends ClassMapperBase<SettingProperties> {
  SettingPropertiesMapper._();

  static SettingPropertiesMapper? _instance;
  static SettingPropertiesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingPropertiesMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SettingProperties';

  static double? _$fontScale(SettingProperties v) => v.fontScale;
  static const Field<SettingProperties, double> _f$fontScale =
      Field('fontScale', _$fontScale, opt: true);
  static String? _$locale(SettingProperties v) => v.locale;
  static const Field<SettingProperties, String> _f$locale =
      Field('locale', _$locale, opt: true);

  @override
  final MappableFields<SettingProperties> fields = const {
    #fontScale: _f$fontScale,
    #locale: _f$locale,
  };

  static SettingProperties _instantiate(DecodingData data) {
    return SettingProperties(
        fontScale: data.dec(_f$fontScale), locale: data.dec(_f$locale));
  }

  @override
  final Function instantiate = _instantiate;

  static SettingProperties fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingProperties>(map);
  }

  static SettingProperties fromJson(String json) {
    return ensureInitialized().decodeJson<SettingProperties>(json);
  }
}

mixin SettingPropertiesMappable {
  String toJson() {
    return SettingPropertiesMapper.ensureInitialized()
        .encodeJson<SettingProperties>(this as SettingProperties);
  }

  Map<String, dynamic> toMap() {
    return SettingPropertiesMapper.ensureInitialized()
        .encodeMap<SettingProperties>(this as SettingProperties);
  }

  SettingPropertiesCopyWith<SettingProperties, SettingProperties,
          SettingProperties>
      get copyWith => _SettingPropertiesCopyWithImpl(
          this as SettingProperties, $identity, $identity);
  @override
  String toString() {
    return SettingPropertiesMapper.ensureInitialized()
        .stringifyValue(this as SettingProperties);
  }

  @override
  bool operator ==(Object other) {
    return SettingPropertiesMapper.ensureInitialized()
        .equalsValue(this as SettingProperties, other);
  }

  @override
  int get hashCode {
    return SettingPropertiesMapper.ensureInitialized()
        .hashValue(this as SettingProperties);
  }
}

extension SettingPropertiesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingProperties, $Out> {
  SettingPropertiesCopyWith<$R, SettingProperties, $Out>
      get $asSettingProperties =>
          $base.as((v, t, t2) => _SettingPropertiesCopyWithImpl(v, t, t2));
}

abstract class SettingPropertiesCopyWith<$R, $In extends SettingProperties,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? fontScale, String? locale});
  SettingPropertiesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SettingPropertiesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SettingProperties, $Out>
    implements SettingPropertiesCopyWith<$R, SettingProperties, $Out> {
  _SettingPropertiesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingProperties> $mapper =
      SettingPropertiesMapper.ensureInitialized();
  @override
  $R call({Object? fontScale = $none, Object? locale = $none}) =>
      $apply(FieldCopyWithData({
        if (fontScale != $none) #fontScale: fontScale,
        if (locale != $none) #locale: locale
      }));
  @override
  SettingProperties $make(CopyWithData data) => SettingProperties(
      fontScale: data.get(#fontScale, or: $value.fontScale),
      locale: data.get(#locale, or: $value.locale));

  @override
  SettingPropertiesCopyWith<$R2, SettingProperties, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SettingPropertiesCopyWithImpl($value, $cast, t);
}
