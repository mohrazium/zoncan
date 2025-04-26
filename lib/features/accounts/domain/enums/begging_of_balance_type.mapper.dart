// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'begging_of_balance_type.dart';

class BeggingOfBalanceTypeMapper extends EnumMapper<BeggingOfBalanceType> {
  BeggingOfBalanceTypeMapper._();

  static BeggingOfBalanceTypeMapper? _instance;
  static BeggingOfBalanceTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BeggingOfBalanceTypeMapper._());
    }
    return _instance!;
  }

  static BeggingOfBalanceType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BeggingOfBalanceType decode(dynamic value) {
    switch (value) {
      case 'DEBTOR':
        return BeggingOfBalanceType.debtor;
      case 'INCALCULABLE':
        return BeggingOfBalanceType.incalculable;
      case 'CREDITOR':
        return BeggingOfBalanceType.creditor;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BeggingOfBalanceType self) {
    switch (self) {
      case BeggingOfBalanceType.debtor:
        return 'DEBTOR';
      case BeggingOfBalanceType.incalculable:
        return 'INCALCULABLE';
      case BeggingOfBalanceType.creditor:
        return 'CREDITOR';
    }
  }
}

extension BeggingOfBalanceTypeMapperExtension on BeggingOfBalanceType {
  dynamic toValue() {
    BeggingOfBalanceTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BeggingOfBalanceType>(this);
  }
}
