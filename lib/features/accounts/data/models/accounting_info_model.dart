part of '../data.dart';

typedef AccountingInfoMapper = AccountingInfoModelMapper;

@MappableClass(
    generateMethods: GenerateMethods.copy |
        GenerateMethods.equals |
        GenerateMethods.stringify |
        GenerateMethods.decode |
        GenerateMethods.encode)
class AccountingInfoModel with AccountingInfoModelMappable {
  final int id;
  final String? uid;
  final DateTime? introDate;
  final String? referralPersonUid;
  final String? category;
  final String? groupOfOff;
  final String? debtCreditLimit;
  final BalanceType balanceType;
  final double beggingOfBalance;
  final BeggingOfBalanceType beggingOfBalanceType;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AccountingInfoModel({
    required this.id,
    this.uid,
    this.introDate,
    this.referralPersonUid,
    this.category,
    this.groupOfOff,
    this.debtCreditLimit,
    required this.balanceType,
    required this.beggingOfBalance,
    required this.beggingOfBalanceType,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
  
 factory AccountingInfoModel.init() => AccountingInfoModel(
        id: 0,
        beggingOfBalance: 0.0,
        balanceType: BalanceType.saleinvoice,
        beggingOfBalanceType: BeggingOfBalanceType.incalculable,
      );

  factory AccountingInfoModel.fromEntity(AccountingInfoEntity entity) =>
      AccountingInfoModel(
        id: entity.id,
        uid: entity.uid,
        introDate: entity.introDate,
        referralPersonUid: entity.referralPersonUid,
        category: entity.category,
        groupOfOff: entity.groupOfOff,
        debtCreditLimit: entity.debtCreditLimit,
        balanceType: entity.balanceType,
        beggingOfBalance: entity.beggingOfBalance,
        beggingOfBalanceType: entity.beggingOfBalanceType,
        description: entity.description,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

 AccountingInfoEntity toEntity() => AccountingInfoEntity(
      id: id,
      uid: uid,
      introDate: introDate,
      referralPersonUid: referralPersonUid,
      category: category,
      groupOfOff: groupOfOff,
      debtCreditLimit: debtCreditLimit,
      balanceType: balanceType,
      beggingOfBalance: beggingOfBalance,
      beggingOfBalanceType: beggingOfBalanceType,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
}
