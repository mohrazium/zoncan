// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'person_model.dart';

class PersonModelMapper extends ClassMapperBase<PersonModel> {
  PersonModelMapper._();

  static PersonModelMapper? _instance;
  static PersonModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PersonModelMapper._());
      UserDetailsModelMapper.ensureInitialized();
      AddressModelMapper.ensureInitialized();
      AccountingInfoModelMapper.ensureInitialized();
      PersonTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PersonModel';

  static int? _$id(PersonModel v) => v.id;
  static const Field<PersonModel, int> _f$id = Field('id', _$id, opt: true);
  static String? _$uid(PersonModel v) => v.uid;
  static const Field<PersonModel, String> _f$uid =
      Field('uid', _$uid, opt: true);
  static UserDetailsModel? _$userDetails(PersonModel v) => v.userDetails;
  static const Field<PersonModel, UserDetailsModel> _f$userDetails =
      Field('userDetails', _$userDetails, opt: true);
  static String _$name(PersonModel v) => v.name;
  static const Field<PersonModel, String> _f$name = Field('name', _$name);
  static String _$family(PersonModel v) => v.family;
  static const Field<PersonModel, String> _f$family = Field('family', _$family);
  static String? _$fatherName(PersonModel v) => v.fatherName;
  static const Field<PersonModel, String> _f$fatherName =
      Field('fatherName', _$fatherName, opt: true);
  static DateTime? _$birthDate(PersonModel v) => v.birthDate;
  static const Field<PersonModel, DateTime> _f$birthDate =
      Field('birthDate', _$birthDate, opt: true);
  static int? _$nationalCode(PersonModel v) => v.nationalCode;
  static const Field<PersonModel, int> _f$nationalCode =
      Field('nationalCode', _$nationalCode, opt: true);
  static String? _$phoneNumber(PersonModel v) => v.phoneNumber;
  static const Field<PersonModel, String> _f$phoneNumber =
      Field('phoneNumber', _$phoneNumber, opt: true);
  static String? _$phoneNumberSms(PersonModel v) => v.phoneNumberSms;
  static const Field<PersonModel, String> _f$phoneNumberSms =
      Field('phoneNumberSms', _$phoneNumberSms, opt: true);
  static String? _$telephone(PersonModel v) => v.telephone;
  static const Field<PersonModel, String> _f$telephone =
      Field('telephone', _$telephone, opt: true);
  static String? _$email(PersonModel v) => v.email;
  static const Field<PersonModel, String> _f$email =
      Field('email', _$email, opt: true);
  static String? _$economicCode(PersonModel v) => v.economicCode;
  static const Field<PersonModel, String> _f$economicCode =
      Field('economicCode', _$economicCode, opt: true);
  static String? _$profilePicture(PersonModel v) => v.profilePicture;
  static const Field<PersonModel, String> _f$profilePicture =
      Field('profilePicture', _$profilePicture, opt: true);
  static AddressModel? _$address(PersonModel v) => v.address;
  static const Field<PersonModel, AddressModel> _f$address =
      Field('address', _$address, opt: true);
  static AccountingInfoModel? _$accountingInfo(PersonModel v) =>
      v.accountingInfo;
  static const Field<PersonModel, AccountingInfoModel> _f$accountingInfo =
      Field('accountingInfo', _$accountingInfo, opt: true);
  static PersonType? _$personType(PersonModel v) => v.personType;
  static const Field<PersonModel, PersonType> _f$personType =
      Field('personType', _$personType, opt: true);
  static String? _$description(PersonModel v) => v.description;
  static const Field<PersonModel, String> _f$description =
      Field('description', _$description, opt: true);
  static DateTime? _$createdAt(PersonModel v) => v.createdAt;
  static const Field<PersonModel, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);
  static DateTime? _$updatedAt(PersonModel v) => v.updatedAt;
  static const Field<PersonModel, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt, opt: true);

  @override
  final MappableFields<PersonModel> fields = const {
    #id: _f$id,
    #uid: _f$uid,
    #userDetails: _f$userDetails,
    #name: _f$name,
    #family: _f$family,
    #fatherName: _f$fatherName,
    #birthDate: _f$birthDate,
    #nationalCode: _f$nationalCode,
    #phoneNumber: _f$phoneNumber,
    #phoneNumberSms: _f$phoneNumberSms,
    #telephone: _f$telephone,
    #email: _f$email,
    #economicCode: _f$economicCode,
    #profilePicture: _f$profilePicture,
    #address: _f$address,
    #accountingInfo: _f$accountingInfo,
    #personType: _f$personType,
    #description: _f$description,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static PersonModel _instantiate(DecodingData data) {
    return PersonModel(
        id: data.dec(_f$id),
        uid: data.dec(_f$uid),
        userDetails: data.dec(_f$userDetails),
        name: data.dec(_f$name),
        family: data.dec(_f$family),
        fatherName: data.dec(_f$fatherName),
        birthDate: data.dec(_f$birthDate),
        nationalCode: data.dec(_f$nationalCode),
        phoneNumber: data.dec(_f$phoneNumber),
        phoneNumberSms: data.dec(_f$phoneNumberSms),
        telephone: data.dec(_f$telephone),
        email: data.dec(_f$email),
        economicCode: data.dec(_f$economicCode),
        profilePicture: data.dec(_f$profilePicture),
        address: data.dec(_f$address),
        accountingInfo: data.dec(_f$accountingInfo),
        personType: data.dec(_f$personType),
        description: data.dec(_f$description),
        createdAt: data.dec(_f$createdAt),
        updatedAt: data.dec(_f$updatedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static PersonModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PersonModel>(map);
  }

  static PersonModel fromJson(String json) {
    return ensureInitialized().decodeJson<PersonModel>(json);
  }
}

mixin PersonModelMappable {
  String toJson() {
    return PersonModelMapper.ensureInitialized()
        .encodeJson<PersonModel>(this as PersonModel);
  }

  Map<String, dynamic> toMap() {
    return PersonModelMapper.ensureInitialized()
        .encodeMap<PersonModel>(this as PersonModel);
  }

  PersonModelCopyWith<PersonModel, PersonModel, PersonModel> get copyWith =>
      _PersonModelCopyWithImpl(this as PersonModel, $identity, $identity);
  @override
  String toString() {
    return PersonModelMapper.ensureInitialized()
        .stringifyValue(this as PersonModel);
  }

  @override
  bool operator ==(Object other) {
    return PersonModelMapper.ensureInitialized()
        .equalsValue(this as PersonModel, other);
  }

  @override
  int get hashCode {
    return PersonModelMapper.ensureInitialized().hashValue(this as PersonModel);
  }
}

extension PersonModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PersonModel, $Out> {
  PersonModelCopyWith<$R, PersonModel, $Out> get $asPersonModel =>
      $base.as((v, t, t2) => _PersonModelCopyWithImpl(v, t, t2));
}

abstract class PersonModelCopyWith<$R, $In extends PersonModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  UserDetailsModelCopyWith<$R, UserDetailsModel, UserDetailsModel>?
      get userDetails;
  AddressModelCopyWith<$R, AddressModel, AddressModel>? get address;
  AccountingInfoModelCopyWith<$R, AccountingInfoModel, AccountingInfoModel>?
      get accountingInfo;
  $R call(
      {int? id,
      String? uid,
      UserDetailsModel? userDetails,
      String? name,
      String? family,
      String? fatherName,
      DateTime? birthDate,
      int? nationalCode,
      String? phoneNumber,
      String? phoneNumberSms,
      String? telephone,
      String? email,
      String? economicCode,
      String? profilePicture,
      AddressModel? address,
      AccountingInfoModel? accountingInfo,
      PersonType? personType,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt});
  PersonModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PersonModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PersonModel, $Out>
    implements PersonModelCopyWith<$R, PersonModel, $Out> {
  _PersonModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PersonModel> $mapper =
      PersonModelMapper.ensureInitialized();
  @override
  UserDetailsModelCopyWith<$R, UserDetailsModel, UserDetailsModel>?
      get userDetails =>
          $value.userDetails?.copyWith.$chain((v) => call(userDetails: v));
  @override
  AddressModelCopyWith<$R, AddressModel, AddressModel>? get address =>
      $value.address?.copyWith.$chain((v) => call(address: v));
  @override
  AccountingInfoModelCopyWith<$R, AccountingInfoModel, AccountingInfoModel>?
      get accountingInfo => $value.accountingInfo?.copyWith
          .$chain((v) => call(accountingInfo: v));
  @override
  $R call(
          {Object? id = $none,
          Object? uid = $none,
          Object? userDetails = $none,
          String? name,
          String? family,
          Object? fatherName = $none,
          Object? birthDate = $none,
          Object? nationalCode = $none,
          Object? phoneNumber = $none,
          Object? phoneNumberSms = $none,
          Object? telephone = $none,
          Object? email = $none,
          Object? economicCode = $none,
          Object? profilePicture = $none,
          Object? address = $none,
          Object? accountingInfo = $none,
          Object? personType = $none,
          Object? description = $none,
          Object? createdAt = $none,
          Object? updatedAt = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (uid != $none) #uid: uid,
        if (userDetails != $none) #userDetails: userDetails,
        if (name != null) #name: name,
        if (family != null) #family: family,
        if (fatherName != $none) #fatherName: fatherName,
        if (birthDate != $none) #birthDate: birthDate,
        if (nationalCode != $none) #nationalCode: nationalCode,
        if (phoneNumber != $none) #phoneNumber: phoneNumber,
        if (phoneNumberSms != $none) #phoneNumberSms: phoneNumberSms,
        if (telephone != $none) #telephone: telephone,
        if (email != $none) #email: email,
        if (economicCode != $none) #economicCode: economicCode,
        if (profilePicture != $none) #profilePicture: profilePicture,
        if (address != $none) #address: address,
        if (accountingInfo != $none) #accountingInfo: accountingInfo,
        if (personType != $none) #personType: personType,
        if (description != $none) #description: description,
        if (createdAt != $none) #createdAt: createdAt,
        if (updatedAt != $none) #updatedAt: updatedAt
      }));
  @override
  PersonModel $make(CopyWithData data) => PersonModel(
      id: data.get(#id, or: $value.id),
      uid: data.get(#uid, or: $value.uid),
      userDetails: data.get(#userDetails, or: $value.userDetails),
      name: data.get(#name, or: $value.name),
      family: data.get(#family, or: $value.family),
      fatherName: data.get(#fatherName, or: $value.fatherName),
      birthDate: data.get(#birthDate, or: $value.birthDate),
      nationalCode: data.get(#nationalCode, or: $value.nationalCode),
      phoneNumber: data.get(#phoneNumber, or: $value.phoneNumber),
      phoneNumberSms: data.get(#phoneNumberSms, or: $value.phoneNumberSms),
      telephone: data.get(#telephone, or: $value.telephone),
      email: data.get(#email, or: $value.email),
      economicCode: data.get(#economicCode, or: $value.economicCode),
      profilePicture: data.get(#profilePicture, or: $value.profilePicture),
      address: data.get(#address, or: $value.address),
      accountingInfo: data.get(#accountingInfo, or: $value.accountingInfo),
      personType: data.get(#personType, or: $value.personType),
      description: data.get(#description, or: $value.description),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt));

  @override
  PersonModelCopyWith<$R2, PersonModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PersonModelCopyWithImpl($value, $cast, t);
}
