part of '../domain.dart';

abstract class AccountingInfoEntity{
  int id;
  String? uid;
  DateTime? introDate;
  String? referralPersonUid;
  String? category;
  String? groupOfOff;
  String? debtCreditLimit;
  BalanceType settlementInCashType;
  double beggingOfBalance;
  BeggingOfBalanceType beggingOfBalanceType;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  AccountingInfoEntity({
    required this.id,
    this.uid,
    this.introDate,
    this.referralPersonUid,
    this.category,
    this.groupOfOff,
    this.debtCreditLimit,
    this.settlementInCashType = BalanceType.saleinvoice,
    required this.beggingOfBalance,
    this.beggingOfBalanceType = BeggingOfBalanceType.incalculable,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
}