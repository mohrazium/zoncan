// ignore_for_file: overridden_fields

part of '../../data.dart';

@Entity()
@JsonSerializable()
class AccountingInfoTable extends AccountingInfoEntity {
  @Id()
  @override
   int id;
  @Unique()
  @override
  final String? uid;
  @override
  final DateTime? introDate;
  @override
  final String? referralPersonUid;
  @override
  final String? category;
  @override
  final String? groupOfOff;
  @override
  final String? debtCreditLimit;
  @Transient()
  @override
  SettlementInCashType? settlementInCash;
  @override
  final double beggingOfBalance;
  @override
  final BeggingOfBalanceType beggingOfBalanceType;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  AccountingInfoTable(
      {required this.id,
      this.uid,
      this.introDate,
      this.referralPersonUid,
      this.category,
      this.groupOfOff,
      this.debtCreditLimit,
      this.settlementInCash,
      required this.beggingOfBalance,
      required this.beggingOfBalanceType,
      this.description,
      this.createdAt,
      this.updatedAt})
      : super(
          id: id,
          uid: uid,
          introDate: introDate,
          referralPersonUid: referralPersonUid,
          category: category,
          groupOfOff: groupOfOff,
          debtCreditLimit: debtCreditLimit,
          settlementInCash: settlementInCash,
          beggingOfBalance: beggingOfBalance,
          beggingOfBalanceType: beggingOfBalanceType,
          description: description,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  int? get dbSettlementInCash => settlementInCash?.index;

  set dbSettlementInCash(int? value) => value == null
      ? settlementInCash = SettlementInCashType.inTheSaleInvoice
      : settlementInCash = SettlementInCashType.values[value];

  factory AccountingInfoTable.fromJson(String jsonString) =>
      _$AccountingInfoTableFromJson(json.decode(jsonString));

  String toJson() => json.encode(_$AccountingInfoTableToJson(this));
}
