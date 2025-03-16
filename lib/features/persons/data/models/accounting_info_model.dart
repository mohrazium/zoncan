part of '../data.dart';

@MappableClass(
    generateMethods: GenerateMethods.copy |
        GenerateMethods.equals |
        GenerateMethods.stringify |
        GenerateMethods.decode |
        GenerateMethods.encode)
class AccountingInfoModel extends AccountingInfoEntity
    with AccountingInfoModelMappable {
  AccountingInfoModel(
      {required super.id,
      super.uid,
      super.introDate,
      super.referralPersonUid,
      super.category,
      super.groupOfOff,
      super.debtCreditLimit,
      super.settlementInCash,
      required super.beggingOfBalance,
      required super.beggingOfBalanceType,
      super.description,
      super.createdAt,
      super.updatedAt});

  factory AccountingInfoModel.init() => AccountingInfoModel(
        id: 0,
        beggingOfBalance: 0,
        beggingOfBalanceType: BeggingOfBalanceType.incalculable,
      );

  factory AccountingInfoModel.fromTable(AccountingInfoTable table) =>
      AccountingInfoModel.fromJson(table.toJson);

  AccountingInfoTable toTable() => AccountingInfoTable.fromJson(toJson());
}
