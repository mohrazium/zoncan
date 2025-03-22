// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'data.dart';

class UserDetailsModelMapper extends ClassMapperBase<UserDetailsModel> {
  UserDetailsModelMapper._();

  static UserDetailsModelMapper? _instance;
  static UserDetailsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserDetailsModelMapper._());
      PersonModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserDetailsModel';

  static int? _$id(UserDetailsModel v) => v.id;
  static const Field<UserDetailsModel, int> _f$id =
      Field('id', _$id, opt: true);
  static String? _$uid(UserDetailsModel v) => v.uid;
  static const Field<UserDetailsModel, String> _f$uid =
      Field('uid', _$uid, opt: true);
  static PersonModel? _$person(UserDetailsModel v) => v.person;
  static const Field<UserDetailsModel, PersonModel> _f$person =
      Field('person', _$person, opt: true);
  static String? _$nickName(UserDetailsModel v) => v.nickName;
  static const Field<UserDetailsModel, String> _f$nickName =
      Field('nickName', _$nickName, opt: true);
  static String _$userName(UserDetailsModel v) => v.userName;
  static const Field<UserDetailsModel, String> _f$userName =
      Field('userName', _$userName);
  static String? _$email(UserDetailsModel v) => v.email;
  static const Field<UserDetailsModel, String> _f$email =
      Field('email', _$email, opt: true);
  static String? _$phoneNumber(UserDetailsModel v) => v.phoneNumber;
  static const Field<UserDetailsModel, String> _f$phoneNumber =
      Field('phoneNumber', _$phoneNumber, opt: true);
  static bool _$isActive(UserDetailsModel v) => v.isActive;
  static const Field<UserDetailsModel, bool> _f$isActive =
      Field('isActive', _$isActive);
  static bool _$isAuthenticated(UserDetailsModel v) => v.isAuthenticated;
  static const Field<UserDetailsModel, bool> _f$isAuthenticated =
      Field('isAuthenticated', _$isAuthenticated);
  static bool _$isEmailVerified(UserDetailsModel v) => v.isEmailVerified;
  static const Field<UserDetailsModel, bool> _f$isEmailVerified =
      Field('isEmailVerified', _$isEmailVerified);
  static bool _$isPhoneNumberVerified(UserDetailsModel v) =>
      v.isPhoneNumberVerified;
  static const Field<UserDetailsModel, bool> _f$isPhoneNumberVerified =
      Field('isPhoneNumberVerified', _$isPhoneNumberVerified);
  static String? _$encryptedPassword(UserDetailsModel v) => v.encryptedPassword;
  static const Field<UserDetailsModel, String> _f$encryptedPassword =
      Field('encryptedPassword', _$encryptedPassword, opt: true);
  static bool? _$isCompletedFirstSetup(UserDetailsModel v) =>
      v.isCompletedFirstSetup;
  static const Field<UserDetailsModel, bool> _f$isCompletedFirstSetup =
      Field('isCompletedFirstSetup', _$isCompletedFirstSetup, opt: true);
  static int? _$setupLevel(UserDetailsModel v) => v.setupLevel;
  static const Field<UserDetailsModel, int> _f$setupLevel =
      Field('setupLevel', _$setupLevel, opt: true);
  static DateTime? _$expirationDate(UserDetailsModel v) => v.expirationDate;
  static const Field<UserDetailsModel, DateTime> _f$expirationDate =
      Field('expirationDate', _$expirationDate, opt: true);
  static DateTime? _$createdAt(UserDetailsModel v) => v.createdAt;
  static const Field<UserDetailsModel, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);
  static DateTime? _$updatedAt(UserDetailsModel v) => v.updatedAt;
  static const Field<UserDetailsModel, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt, opt: true);

  @override
  final MappableFields<UserDetailsModel> fields = const {
    #id: _f$id,
    #uid: _f$uid,
    #person: _f$person,
    #nickName: _f$nickName,
    #userName: _f$userName,
    #email: _f$email,
    #phoneNumber: _f$phoneNumber,
    #isActive: _f$isActive,
    #isAuthenticated: _f$isAuthenticated,
    #isEmailVerified: _f$isEmailVerified,
    #isPhoneNumberVerified: _f$isPhoneNumberVerified,
    #encryptedPassword: _f$encryptedPassword,
    #isCompletedFirstSetup: _f$isCompletedFirstSetup,
    #setupLevel: _f$setupLevel,
    #expirationDate: _f$expirationDate,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static UserDetailsModel _instantiate(DecodingData data) {
    return UserDetailsModel(
        id: data.dec(_f$id),
        uid: data.dec(_f$uid),
        person: data.dec(_f$person),
        nickName: data.dec(_f$nickName),
        userName: data.dec(_f$userName),
        email: data.dec(_f$email),
        phoneNumber: data.dec(_f$phoneNumber),
        isActive: data.dec(_f$isActive),
        isAuthenticated: data.dec(_f$isAuthenticated),
        isEmailVerified: data.dec(_f$isEmailVerified),
        isPhoneNumberVerified: data.dec(_f$isPhoneNumberVerified),
        encryptedPassword: data.dec(_f$encryptedPassword),
        isCompletedFirstSetup: data.dec(_f$isCompletedFirstSetup),
        setupLevel: data.dec(_f$setupLevel),
        expirationDate: data.dec(_f$expirationDate),
        createdAt: data.dec(_f$createdAt),
        updatedAt: data.dec(_f$updatedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static UserDetailsModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserDetailsModel>(map);
  }

  static UserDetailsModel fromJson(String json) {
    return ensureInitialized().decodeJson<UserDetailsModel>(json);
  }
}

mixin UserDetailsModelMappable {
  String toJson() {
    return UserDetailsModelMapper.ensureInitialized()
        .encodeJson<UserDetailsModel>(this as UserDetailsModel);
  }

  Map<String, dynamic> toMap() {
    return UserDetailsModelMapper.ensureInitialized()
        .encodeMap<UserDetailsModel>(this as UserDetailsModel);
  }

  UserDetailsModelCopyWith<UserDetailsModel, UserDetailsModel, UserDetailsModel>
      get copyWith => _UserDetailsModelCopyWithImpl(
          this as UserDetailsModel, $identity, $identity);
  @override
  String toString() {
    return UserDetailsModelMapper.ensureInitialized()
        .stringifyValue(this as UserDetailsModel);
  }

  @override
  bool operator ==(Object other) {
    return UserDetailsModelMapper.ensureInitialized()
        .equalsValue(this as UserDetailsModel, other);
  }

  @override
  int get hashCode {
    return UserDetailsModelMapper.ensureInitialized()
        .hashValue(this as UserDetailsModel);
  }
}

extension UserDetailsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserDetailsModel, $Out> {
  UserDetailsModelCopyWith<$R, UserDetailsModel, $Out>
      get $asUserDetailsModel =>
          $base.as((v, t, t2) => _UserDetailsModelCopyWithImpl(v, t, t2));
}

abstract class UserDetailsModelCopyWith<$R, $In extends UserDetailsModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PersonModelCopyWith<$R, PersonModel, PersonModel>? get person;
  $R call(
      {int? id,
      String? uid,
      PersonModel? person,
      String? nickName,
      String? userName,
      String? email,
      String? phoneNumber,
      bool? isActive,
      bool? isAuthenticated,
      bool? isEmailVerified,
      bool? isPhoneNumberVerified,
      String? encryptedPassword,
      bool? isCompletedFirstSetup,
      int? setupLevel,
      DateTime? expirationDate,
      DateTime? createdAt,
      DateTime? updatedAt});
  UserDetailsModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _UserDetailsModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserDetailsModel, $Out>
    implements UserDetailsModelCopyWith<$R, UserDetailsModel, $Out> {
  _UserDetailsModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserDetailsModel> $mapper =
      UserDetailsModelMapper.ensureInitialized();
  @override
  PersonModelCopyWith<$R, PersonModel, PersonModel>? get person =>
      $value.person?.copyWith.$chain((v) => call(person: v));
  @override
  $R call(
          {Object? id = $none,
          Object? uid = $none,
          Object? person = $none,
          Object? nickName = $none,
          String? userName,
          Object? email = $none,
          Object? phoneNumber = $none,
          bool? isActive,
          bool? isAuthenticated,
          bool? isEmailVerified,
          bool? isPhoneNumberVerified,
          Object? encryptedPassword = $none,
          Object? isCompletedFirstSetup = $none,
          Object? setupLevel = $none,
          Object? expirationDate = $none,
          Object? createdAt = $none,
          Object? updatedAt = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (uid != $none) #uid: uid,
        if (person != $none) #person: person,
        if (nickName != $none) #nickName: nickName,
        if (userName != null) #userName: userName,
        if (email != $none) #email: email,
        if (phoneNumber != $none) #phoneNumber: phoneNumber,
        if (isActive != null) #isActive: isActive,
        if (isAuthenticated != null) #isAuthenticated: isAuthenticated,
        if (isEmailVerified != null) #isEmailVerified: isEmailVerified,
        if (isPhoneNumberVerified != null)
          #isPhoneNumberVerified: isPhoneNumberVerified,
        if (encryptedPassword != $none) #encryptedPassword: encryptedPassword,
        if (isCompletedFirstSetup != $none)
          #isCompletedFirstSetup: isCompletedFirstSetup,
        if (setupLevel != $none) #setupLevel: setupLevel,
        if (expirationDate != $none) #expirationDate: expirationDate,
        if (createdAt != $none) #createdAt: createdAt,
        if (updatedAt != $none) #updatedAt: updatedAt
      }));
  @override
  UserDetailsModel $make(CopyWithData data) => UserDetailsModel(
      id: data.get(#id, or: $value.id),
      uid: data.get(#uid, or: $value.uid),
      person: data.get(#person, or: $value.person),
      nickName: data.get(#nickName, or: $value.nickName),
      userName: data.get(#userName, or: $value.userName),
      email: data.get(#email, or: $value.email),
      phoneNumber: data.get(#phoneNumber, or: $value.phoneNumber),
      isActive: data.get(#isActive, or: $value.isActive),
      isAuthenticated: data.get(#isAuthenticated, or: $value.isAuthenticated),
      isEmailVerified: data.get(#isEmailVerified, or: $value.isEmailVerified),
      isPhoneNumberVerified:
          data.get(#isPhoneNumberVerified, or: $value.isPhoneNumberVerified),
      encryptedPassword:
          data.get(#encryptedPassword, or: $value.encryptedPassword),
      isCompletedFirstSetup:
          data.get(#isCompletedFirstSetup, or: $value.isCompletedFirstSetup),
      setupLevel: data.get(#setupLevel, or: $value.setupLevel),
      expirationDate: data.get(#expirationDate, or: $value.expirationDate),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt));

  @override
  UserDetailsModelCopyWith<$R2, UserDetailsModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserDetailsModelCopyWithImpl($value, $cast, t);
}

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

  static int _$id(PersonModel v) => v.id;
  static const Field<PersonModel, int> _f$id = Field('id', _$id);
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
          {int? id,
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
        if (id != null) #id: id,
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

  static int _$id(AddressModel v) => v.id;
  static const Field<AddressModel, int> _f$id = Field('id', _$id);
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
    #id: _f$id,
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
        id: data.dec(_f$id),
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
      {int? id,
      String? uid,
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
          {int? id,
          Object? uid = $none,
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
        if (id != null) #id: id,
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
      id: data.get(#id, or: $value.id),
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

class AccountingInfoModelMapper extends ClassMapperBase<AccountingInfoModel> {
  AccountingInfoModelMapper._();

  static AccountingInfoModelMapper? _instance;
  static AccountingInfoModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AccountingInfoModelMapper._());
      BalanceTypeMapper.ensureInitialized();
      BeggingOfBalanceTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AccountingInfoModel';

  static int _$id(AccountingInfoModel v) => v.id;
  static const Field<AccountingInfoModel, int> _f$id = Field('id', _$id);
  static String? _$uid(AccountingInfoModel v) => v.uid;
  static const Field<AccountingInfoModel, String> _f$uid =
      Field('uid', _$uid, opt: true);
  static DateTime? _$introDate(AccountingInfoModel v) => v.introDate;
  static const Field<AccountingInfoModel, DateTime> _f$introDate =
      Field('introDate', _$introDate, opt: true);
  static String? _$referralPersonUid(AccountingInfoModel v) =>
      v.referralPersonUid;
  static const Field<AccountingInfoModel, String> _f$referralPersonUid =
      Field('referralPersonUid', _$referralPersonUid, opt: true);
  static String? _$category(AccountingInfoModel v) => v.category;
  static const Field<AccountingInfoModel, String> _f$category =
      Field('category', _$category, opt: true);
  static String? _$groupOfOff(AccountingInfoModel v) => v.groupOfOff;
  static const Field<AccountingInfoModel, String> _f$groupOfOff =
      Field('groupOfOff', _$groupOfOff, opt: true);
  static String? _$debtCreditLimit(AccountingInfoModel v) => v.debtCreditLimit;
  static const Field<AccountingInfoModel, String> _f$debtCreditLimit =
      Field('debtCreditLimit', _$debtCreditLimit, opt: true);
  static BalanceType _$balanceType(AccountingInfoModel v) => v.balanceType;
  static const Field<AccountingInfoModel, BalanceType> _f$balanceType =
      Field('balanceType', _$balanceType);
  static double _$beggingOfBalance(AccountingInfoModel v) => v.beggingOfBalance;
  static const Field<AccountingInfoModel, double> _f$beggingOfBalance =
      Field('beggingOfBalance', _$beggingOfBalance);
  static BeggingOfBalanceType _$beggingOfBalanceType(AccountingInfoModel v) =>
      v.beggingOfBalanceType;
  static const Field<AccountingInfoModel, BeggingOfBalanceType>
      _f$beggingOfBalanceType =
      Field('beggingOfBalanceType', _$beggingOfBalanceType);
  static String? _$description(AccountingInfoModel v) => v.description;
  static const Field<AccountingInfoModel, String> _f$description =
      Field('description', _$description, opt: true);
  static DateTime? _$createdAt(AccountingInfoModel v) => v.createdAt;
  static const Field<AccountingInfoModel, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);
  static DateTime? _$updatedAt(AccountingInfoModel v) => v.updatedAt;
  static const Field<AccountingInfoModel, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt, opt: true);

  @override
  final MappableFields<AccountingInfoModel> fields = const {
    #id: _f$id,
    #uid: _f$uid,
    #introDate: _f$introDate,
    #referralPersonUid: _f$referralPersonUid,
    #category: _f$category,
    #groupOfOff: _f$groupOfOff,
    #debtCreditLimit: _f$debtCreditLimit,
    #balanceType: _f$balanceType,
    #beggingOfBalance: _f$beggingOfBalance,
    #beggingOfBalanceType: _f$beggingOfBalanceType,
    #description: _f$description,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static AccountingInfoModel _instantiate(DecodingData data) {
    return AccountingInfoModel(
        id: data.dec(_f$id),
        uid: data.dec(_f$uid),
        introDate: data.dec(_f$introDate),
        referralPersonUid: data.dec(_f$referralPersonUid),
        category: data.dec(_f$category),
        groupOfOff: data.dec(_f$groupOfOff),
        debtCreditLimit: data.dec(_f$debtCreditLimit),
        balanceType: data.dec(_f$balanceType),
        beggingOfBalance: data.dec(_f$beggingOfBalance),
        beggingOfBalanceType: data.dec(_f$beggingOfBalanceType),
        description: data.dec(_f$description),
        createdAt: data.dec(_f$createdAt),
        updatedAt: data.dec(_f$updatedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static AccountingInfoModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AccountingInfoModel>(map);
  }

  static AccountingInfoModel fromJson(String json) {
    return ensureInitialized().decodeJson<AccountingInfoModel>(json);
  }
}

mixin AccountingInfoModelMappable {
  String toJson() {
    return AccountingInfoModelMapper.ensureInitialized()
        .encodeJson<AccountingInfoModel>(this as AccountingInfoModel);
  }

  Map<String, dynamic> toMap() {
    return AccountingInfoModelMapper.ensureInitialized()
        .encodeMap<AccountingInfoModel>(this as AccountingInfoModel);
  }

  AccountingInfoModelCopyWith<AccountingInfoModel, AccountingInfoModel,
          AccountingInfoModel>
      get copyWith => _AccountingInfoModelCopyWithImpl(
          this as AccountingInfoModel, $identity, $identity);
  @override
  String toString() {
    return AccountingInfoModelMapper.ensureInitialized()
        .stringifyValue(this as AccountingInfoModel);
  }

  @override
  bool operator ==(Object other) {
    return AccountingInfoModelMapper.ensureInitialized()
        .equalsValue(this as AccountingInfoModel, other);
  }

  @override
  int get hashCode {
    return AccountingInfoModelMapper.ensureInitialized()
        .hashValue(this as AccountingInfoModel);
  }
}

extension AccountingInfoModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AccountingInfoModel, $Out> {
  AccountingInfoModelCopyWith<$R, AccountingInfoModel, $Out>
      get $asAccountingInfoModel =>
          $base.as((v, t, t2) => _AccountingInfoModelCopyWithImpl(v, t, t2));
}

abstract class AccountingInfoModelCopyWith<$R, $In extends AccountingInfoModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      String? uid,
      DateTime? introDate,
      String? referralPersonUid,
      String? category,
      String? groupOfOff,
      String? debtCreditLimit,
      BalanceType? balanceType,
      double? beggingOfBalance,
      BeggingOfBalanceType? beggingOfBalanceType,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt});
  AccountingInfoModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AccountingInfoModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AccountingInfoModel, $Out>
    implements AccountingInfoModelCopyWith<$R, AccountingInfoModel, $Out> {
  _AccountingInfoModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AccountingInfoModel> $mapper =
      AccountingInfoModelMapper.ensureInitialized();
  @override
  $R call(
          {int? id,
          Object? uid = $none,
          Object? introDate = $none,
          Object? referralPersonUid = $none,
          Object? category = $none,
          Object? groupOfOff = $none,
          Object? debtCreditLimit = $none,
          BalanceType? balanceType,
          double? beggingOfBalance,
          BeggingOfBalanceType? beggingOfBalanceType,
          Object? description = $none,
          Object? createdAt = $none,
          Object? updatedAt = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (uid != $none) #uid: uid,
        if (introDate != $none) #introDate: introDate,
        if (referralPersonUid != $none) #referralPersonUid: referralPersonUid,
        if (category != $none) #category: category,
        if (groupOfOff != $none) #groupOfOff: groupOfOff,
        if (debtCreditLimit != $none) #debtCreditLimit: debtCreditLimit,
        if (balanceType != null) #balanceType: balanceType,
        if (beggingOfBalance != null) #beggingOfBalance: beggingOfBalance,
        if (beggingOfBalanceType != null)
          #beggingOfBalanceType: beggingOfBalanceType,
        if (description != $none) #description: description,
        if (createdAt != $none) #createdAt: createdAt,
        if (updatedAt != $none) #updatedAt: updatedAt
      }));
  @override
  AccountingInfoModel $make(CopyWithData data) => AccountingInfoModel(
      id: data.get(#id, or: $value.id),
      uid: data.get(#uid, or: $value.uid),
      introDate: data.get(#introDate, or: $value.introDate),
      referralPersonUid:
          data.get(#referralPersonUid, or: $value.referralPersonUid),
      category: data.get(#category, or: $value.category),
      groupOfOff: data.get(#groupOfOff, or: $value.groupOfOff),
      debtCreditLimit: data.get(#debtCreditLimit, or: $value.debtCreditLimit),
      balanceType: data.get(#balanceType, or: $value.balanceType),
      beggingOfBalance:
          data.get(#beggingOfBalance, or: $value.beggingOfBalance),
      beggingOfBalanceType:
          data.get(#beggingOfBalanceType, or: $value.beggingOfBalanceType),
      description: data.get(#description, or: $value.description),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt));

  @override
  AccountingInfoModelCopyWith<$R2, AccountingInfoModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _AccountingInfoModelCopyWithImpl($value, $cast, t);
}
