import 'package:dart_mappable/dart_mappable.dart';
part 'balance_type.mapper.dart';

@MappableEnum()
enum BalanceType {
  @MappableValue('SALE_INVOICE')
  saleinvoice(1, 'SALE_INVOICE', "در صورت حساب", "In sale invoice"),
  @MappableValue('RETURN_FROM_SALE')
  returnfromsale(2, "RETURN_FROM_SALE", "برگشت از خرید", "Return from sale");

  const BalanceType(int code, String type, String titleFa, String titleEn);
  static BalanceType fromCode(int code) {
    return values.firstWhere((e) => e.index + 1 == code);
  }
}
