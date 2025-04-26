import 'package:dart_mappable/dart_mappable.dart';
part 'person_type.mapper.dart';

@MappableEnum()
enum PersonType {
  @MappableValue("ALL")
  all(1, "ALL", "همه", "All"),
  @MappableValue("SELLER")
  seller(2, "SELLER", "فروشنده", "Seller"),
  @MappableValue("MARKETER")
  marketer(3, "MARKETER", "بازاریاب", "Marketer"),
  @MappableValue("CUSTOMER")
  customer(4, "CUSTOMER", "مشتری", "Customer"),
  @MappableValue("PERSONNEL")
  personnel(5, "PERSONNEL", "پرسنل", "Personnel"),
  @MappableValue("SHAREHOLDER")
  shareholder(6, "SHAREHOLDER", "سهامدار", "Share Holder");

  final int code;
  final String type;
  final String titleFa;
  final String titleEn;
  const PersonType(this.code, this.type, this.titleFa, this.titleEn);
}
