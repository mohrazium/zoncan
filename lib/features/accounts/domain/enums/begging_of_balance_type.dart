import 'package:dart_mappable/dart_mappable.dart';
part 'begging_of_balance_type.mapper.dart';

@MappableEnum()
enum BeggingOfBalanceType {
  @MappableValue('DEBTOR')
  debtor(1, 'DEBTOR', "بدهکار", "In sale invoice"),
  @MappableValue('INCALCULABLE')
  incalculable(2, "INCALCULABLE", "محاسبه نشده", "Incalculable"),
  @MappableValue('CREDITOR')
  creditor(3, "CREDITOR", "طلبکار", "Creditor");

  const BeggingOfBalanceType(
    int code,
    String type,
    String titleFa,
    String titleEn,
  );
  static BeggingOfBalanceType fromCode(int code) {
    return values.firstWhere((e) => e.index + 1 == code);
  }
}
