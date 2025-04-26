
import '../enums/balance_type.dart';
import '../enums/begging_of_balance_type.dart';

class AccountingInfoEntity {
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

  AccountingInfoEntity({
    this.uid,
    this.introDate,
    this.referralPersonUid,
    this.category,
    this.groupOfOff,
    this.debtCreditLimit,
    this.balanceType = BalanceType.saleinvoice,
    required this.beggingOfBalance,
    this.beggingOfBalanceType = BeggingOfBalanceType.incalculable,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
}
