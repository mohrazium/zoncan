import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entity/accounting_info_entity.dart';
import '../../domain/enums/balance_type.dart';
import '../../domain/enums/begging_of_balance_type.dart';

part 'accounting_info_model.mapper.dart';

typedef AccountingInfoMapper = AccountingInfoModelMapper;

@MappableClass(
  generateMethods:
      GenerateMethods.copy |
      GenerateMethods.equals |
      GenerateMethods.stringify |
      GenerateMethods.decode |
      GenerateMethods.encode,
)
class AccountingInfoModel with AccountingInfoModelMappable {
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
    beggingOfBalance: 0.0,
    balanceType: BalanceType.saleinvoice,
    beggingOfBalanceType: BeggingOfBalanceType.incalculable,
  );

  factory AccountingInfoModel.fromEntity(AccountingInfoEntity entity) =>
      AccountingInfoModel(
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
