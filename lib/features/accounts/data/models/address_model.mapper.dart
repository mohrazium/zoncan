// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'address_model.dart';

class AddressModelMapper extends ClassMapperBase<AddressModel> {
  AddressModelMapper._();

  static AddressModelMapper? _instance;
  static AddressModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AddressModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AddressModel';

  static String? _$uid(AddressModel v) => v.uid;
  static const Field<AddressModel, String> _f$uid =
      Field('uid', _$uid, opt: true);
  static String? _$postalCode(AddressModel v) => v.postalCode;
  static const Field<AddressModel, String> _f$postalCode =
      Field('postalCode', _$postalCode, opt: true);
  static String? _$province(AddressModel v) => v.province;
  static const Field<AddressModel, String> _f$province =
      Field('province', _$province, opt: true);
  static String? _$county(AddressModel v) => v.county;
  static const Field<AddressModel, String> _f$county =
      Field('county', _$county, opt: true);
  static String? _$city(AddressModel v) => v.city;
  static const Field<AddressModel, String> _f$city =
      Field('city', _$city, opt: true);
  static String? _$blv(AddressModel v) => v.blv;
  static const Field<AddressModel, String> _f$blv =
      Field('blv', _$blv, opt: true);
  static String _$fullAddress(AddressModel v) => v.fullAddress;
  static const Field<AddressModel, String> _f$fullAddress =
      Field('fullAddress', _$fullAddress);
  static String? _$description(AddressModel v) => v.description;
  static const Field<AddressModel, String> _f$description =
      Field('description', _$description, opt: true);
  static DateTime? _$createdAt(AddressModel v) => v.createdAt;
  static const Field<AddressModel, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);
  static DateTime? _$updatedAt(AddressModel v) => v.updatedAt;
  static const Field<AddressModel, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt, opt: true);

  @override
  final MappableFields<AddressModel> fields = const {
    #uid: _f$uid,
    #postalCode: _f$postalCode,
    #province: _f$province,
    #county: _f$county,
    #city: _f$city,
    #blv: _f$blv,
    #fullAddress: _f$fullAddress,
    #description: _f$description,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static AddressModel _instantiate(DecodingData data) {
    return AddressModel(
        uid: data.dec(_f$uid),
        postalCode: data.dec(_f$postalCode),
        province: data.dec(_f$province),
        county: data.dec(_f$county),
        city: data.dec(_f$city),
        blv: data.dec(_f$blv),
        fullAddress: data.dec(_f$fullAddress),
        description: data.dec(_f$description),
        createdAt: data.dec(_f$createdAt),
        updatedAt: data.dec(_f$updatedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static AddressModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AddressModel>(map);
  }

  static AddressModel fromJson(String json) {
    return ensureInitialized().decodeJson<AddressModel>(json);
  }
}

mixin AddressModelMappable {
  String toJson() {
    return AddressModelMapper.ensureInitialized()
        .encodeJson<AddressModel>(this as AddressModel);
  }

  Map<String, dynamic> toMap() {
    return AddressModelMapper.ensureInitialized()
        .encodeMap<AddressModel>(this as AddressModel);
  }

  AddressModelCopyWith<AddressModel, AddressModel, AddressModel> get copyWith =>
      _AddressModelCopyWithImpl(this as AddressModel, $identity, $identity);
  @override
  String toString() {
    return AddressModelMapper.ensureInitialized()
        .stringifyValue(this as AddressModel);
  }

  @override
  bool operator ==(Object other) {
    return AddressModelMapper.ensureInitialized()
        .equalsValue(this as AddressModel, other);
  }

  @override
  int get hashCode {
    return AddressModelMapper.ensureInitialized()
        .hashValue(this as AddressModel);
  }
}

extension AddressModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AddressModel, $Out> {
  AddressModelCopyWith<$R, AddressModel, $Out> get $asAddressModel =>
      $base.as((v, t, t2) => _AddressModelCopyWithImpl(v, t, t2));
}

abstract class AddressModelCopyWith<$R, $In extends AddressModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? uid,
      String? postalCode,
      String? province,
      String? county,
      String? city,
      String? blv,
      String? fullAddress,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt});
  AddressModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AddressModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AddressModel, $Out>
    implements AddressModelCopyWith<$R, AddressModel, $Out> {
  _AddressModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AddressModel> $mapper =
      AddressModelMapper.ensureInitialized();
  @override
  $R call(
          {Object? uid = $none,
          Object? postalCode = $none,
          Object? province = $none,
          Object? county = $none,
          Object? city = $none,
          Object? blv = $none,
          String? fullAddress,
          Object? description = $none,
          Object? createdAt = $none,
          Object? updatedAt = $none}) =>
      $apply(FieldCopyWithData({
        if (uid != $none) #uid: uid,
        if (postalCode != $none) #postalCode: postalCode,
        if (province != $none) #province: province,
        if (county != $none) #county: county,
        if (city != $none) #city: city,
        if (blv != $none) #blv: blv,
        if (fullAddress != null) #fullAddress: fullAddress,
        if (description != $none) #description: description,
        if (createdAt != $none) #createdAt: createdAt,
        if (updatedAt != $none) #updatedAt: updatedAt
      }));
  @override
  AddressModel $make(CopyWithData data) => AddressModel(
      uid: data.get(#uid, or: $value.uid),
      postalCode: data.get(#postalCode, or: $value.postalCode),
      province: data.get(#province, or: $value.province),
      county: data.get(#county, or: $value.county),
      city: data.get(#city, or: $value.city),
      blv: data.get(#blv, or: $value.blv),
      fullAddress: data.get(#fullAddress, or: $value.fullAddress),
      description: data.get(#description, or: $value.description),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt));

  @override
  AddressModelCopyWith<$R2, AddressModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AddressModelCopyWithImpl($value, $cast, t);
}
