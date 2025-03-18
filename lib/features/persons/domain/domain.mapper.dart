// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'domain.dart';

class PersonTypeMapper extends EnumMapper<PersonType> {
  PersonTypeMapper._();

  static PersonTypeMapper? _instance;
  static PersonTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PersonTypeMapper._());
    }
    return _instance!;
  }

  static PersonType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PersonType decode(dynamic value) {
    switch (value) {
      case "ALL":
        return PersonType.all;
      case "SELLER":
        return PersonType.seller;
      case "MARKETER":
        return PersonType.marketer;
      case "CUSTOMER":
        return PersonType.customer;
      case "PERSONNEL":
        return PersonType.personnel;
      case "SHAREHOLDER":
        return PersonType.shareholder;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PersonType self) {
    switch (self) {
      case PersonType.all:
        return "ALL";
      case PersonType.seller:
        return "SELLER";
      case PersonType.marketer:
        return "MARKETER";
      case PersonType.customer:
        return "CUSTOMER";
      case PersonType.personnel:
        return "PERSONNEL";
      case PersonType.shareholder:
        return "SHAREHOLDER";
    }
  }
}

extension PersonTypeMapperExtension on PersonType {
  dynamic toValue() {
    PersonTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PersonType>(this);
  }
}

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
