part of '../../../data.dart';

@DataClassName('AccountingInfoData')
class AccountingInfoTable extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get uid => text().nullable().unique()();
  DateTimeColumn get introDate => dateTime().nullable()();
  TextColumn get referralPersonUid => text().nullable()();
  TextColumn get category => text().nullable()();
  TextColumn get groupOfOff => text().nullable()();
  TextColumn get debtCreditLimit => text().nullable()();
  IntColumn get settlementTypeCode => integer()();
  RealColumn get beggingOfBalance => real()();
  IntColumn get balanceTypeCode => integer()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
 @override
  Set<Column> get primaryKey => {id};
}

extension AccountingInfoDataExtension on AccountingInfoData {
  AccountingInfoEntity toEntity() => AccountingInfoEntity(
        id: id??0,
        uid: uid,
        introDate: introDate,
        referralPersonUid: referralPersonUid,
        category: category,
        groupOfOff: groupOfOff,
        debtCreditLimit: debtCreditLimit,
        balanceType: BalanceType.fromCode(settlementTypeCode),
        beggingOfBalance: beggingOfBalance,
        beggingOfBalanceType: BeggingOfBalanceType.fromCode(balanceTypeCode),
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension AccountingInfoEntityExtension on AccountingInfoEntity {
  AccountingInfoData toData() => AccountingInfoData(
        id: id,
        uid: uid,
        introDate: introDate,
        referralPersonUid: referralPersonUid,
        category: category,
        groupOfOff: groupOfOff,
        debtCreditLimit: debtCreditLimit,
        settlementTypeCode: balanceType.index+1,
        beggingOfBalance: beggingOfBalance,
        balanceTypeCode: beggingOfBalanceType.index+1,
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}