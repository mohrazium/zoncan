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
    }
    return _instance!;
  }

  @override
  final String id = 'UserDetailsModel';

  static int _$id(UserDetailsModel v) => v.id;
  static const Field<UserDetailsModel, int> _f$id = Field('id', _$id);
  static String? _$uid(UserDetailsModel v) => v.uid;
  static const Field<UserDetailsModel, String> _f$uid =
      Field('uid', _$uid, opt: true);
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
  $R call(
      {int? id,
      String? uid,
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
  $R call(
          {int? id,
          Object? uid = $none,
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
        if (id != null) #id: id,
        if (uid != $none) #uid: uid,
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
