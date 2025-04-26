// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'balance_type.dart';

class BalanceTypeMapper extends EnumMapper<BalanceType> {
  BalanceTypeMapper._();

  static BalanceTypeMapper? _instance;
  static BalanceTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BalanceTypeMapper._());
    }
    return _instance!;
  }

  static BalanceType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BalanceType decode(dynamic value) {
    switch (value) {
      case 'SALE_INVOICE':
        return BalanceType.saleinvoice;
      case 'RETURN_FROM_SALE':
        return BalanceType.returnfromsale;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BalanceType self) {
    switch (self) {
      case BalanceType.saleinvoice:
        return 'SALE_INVOICE';
      case BalanceType.returnfromsale:
        return 'RETURN_FROM_SALE';
    }
  }
}

extension BalanceTypeMapperExtension on BalanceType {
  dynamic toValue() {
    BalanceTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BalanceType>(this);
  }
}
