part of '../domain.dart';

class AccountingInfoEntity {
  final int id;
  final String? uid;
  final DateTime? introDate;
  final String? referralPersonUid;
  final String? category;
  final String? groupOfOff;
  final String? debtCreditLimit;
  final String? settlementInCashType;
  final double beggingOfBalance;
  final int beggingOfBalanceType;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AccountingInfoEntity({
    required this.id,
    this.uid,
    this.introDate,
    this.referralPersonUid,
    this.category,
    this.groupOfOff,
    this.debtCreditLimit,
    this.settlementInCashType,
    required this.beggingOfBalance,
    required this.beggingOfBalanceType,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
}
