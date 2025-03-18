part of '../data.dart';

typedef AccountingInfoMapper = AccountingInfoModelMapper;

@MappableClass(
    generateMethods: GenerateMethods.copy |
    GenerateMethods.equals |
    GenerateMethods.stringify |
    GenerateMethods.decode |
    GenerateMethods.encode)class AccountingInfoModel extends AccountingInfoEntity with AccountingInfoModelMappable {
  AccountingInfoModel({
    required super.id,
    super.uid,
    super.introDate,
    super.referralPersonUid,
    super.category,
    super.groupOfOff,
    super.debtCreditLimit,
    super.settlementInCashType,
    required super.beggingOfBalance,
    super.beggingOfBalanceType,
    super.description,
    super.createdAt,
    super.updatedAt,
  });

  factory AccountingInfoModel.init() => AccountingInfoModel(
    id: 0,
    beggingOfBalance: 0.0,
    settlementInCashType: BalanceType.saleinvoice,
    beggingOfBalanceType: BeggingOfBalanceType.incalculable,
  );


  factory AccountingInfoModel.fromTable(AccountingInfoTable table) {
    return AccountingInfoModel(
      id: table.id,
      uid: table.uid,
      introDate: table.introDate,
      referralPersonUid: table.referralPersonUid,
      category: table.category,
      groupOfOff: table.groupOfOff,
      debtCreditLimit: table.debtCreditLimit,
      settlementInCashType: BalanceType.fromCode(table.settlementInCashType.index + 1),
      beggingOfBalance: table.beggingOfBalance,
      beggingOfBalanceType: BeggingOfBalanceType.fromCode(table.beggingOfBalanceType.index + 1),
      description: table.description,
      createdAt: table.createdAt,
      updatedAt: table.updatedAt,
    );
  }

   AccountingInfoTable toTable() {
    return AccountingInfoTable(
      id: this.id,
      uid: this.uid,
      introDate: this.introDate,
      referralPersonUid: this.referralPersonUid,
      category: this.category,
      groupOfOff: this.groupOfOff,
      debtCreditLimit: this.debtCreditLimit,
      settlementTypeCode: this.settlementInCashType.index + 1,
      beggingOfBalance: this.beggingOfBalance,
      balanceTypeCode: this.beggingOfBalanceType.index + 1,
      description: this.description,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
    );
  }
}
