part of '../data.dart';

enum PersonType {
  nothing("Nothing", "هیچکدام"),
  unknown("Unknown", "ناشناس"),
  customer("Customer", "مشتری"),
  seller("Seller", "فروشنده"),
  marketer("Marketer", "بازاریاب"),
  personnel("Personnel", "پرسنل"),
  shareHolder("ShareHolder", "سهامدار");

  const PersonType(
    this.nameEn,
    this.nameFa,
  );

  final String nameEn;
  final String nameFa;
}

enum SettlementInCashType {
  inTheSaleInvoice("InTheSaleInvoice", ""),
  returnFromSale,

  const SettlementInCashType(
      this.nameEn,
      this.nameFa,
      );

  final String nameEn;
  final String nameFa;
}

enum BeggingOfBalanceType {
  debtor,
  incalculable,
  creditor,
}
