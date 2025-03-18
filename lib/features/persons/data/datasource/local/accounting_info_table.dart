// ignore_for_file: overridden_fields

part of '../../data.dart';

@Entity()
@JsonSerializable()
class AccountingInfoTable {
  @Id()
  int id;
  @Unique()
  String? uid;
  @Property(type: PropertyType.date)
  DateTime? introDate;
  String? referralPersonUid;
  String? category;
  String? groupOfOff;
  String? debtCreditLimit;
  @Transient()
  BalanceType get settlementInCashType =>
      BalanceType.fromCode(_settlementTypeCode);
  @Property(type: PropertyType.int)
  int _settlementTypeCode;
  double beggingOfBalance;
  @Transient()
  BeggingOfBalanceType get beggingOfBalanceType =>
      BeggingOfBalanceType.fromCode(_balanceTypeCode);
  @Property(type: PropertyType.int)
  int _balanceTypeCode;
  String? description;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  AccountingInfoTable({
    required this.id,
    this.uid,
    this.introDate,
    this.referralPersonUid,
    this.category,
    this.groupOfOff,
    this.debtCreditLimit,
    int settlementTypeCode = 1,
    required this.beggingOfBalance,
    int balanceTypeCode = 2,
    this.description,
    this.createdAt,
    this.updatedAt,
  })  : _balanceTypeCode = balanceTypeCode,
        _settlementTypeCode = settlementTypeCode;

  factory AccountingInfoTable.fromJson(String jsonString) =>
      _$AccountingInfoTableFromJson(json.decode(jsonString));

  String toJson() => json.encode(_$AccountingInfoTableToJson(this));
}
