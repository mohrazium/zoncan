// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'accounting_info_model.dart';

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
      {String? uid,
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
          {Object? uid = $none,
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
