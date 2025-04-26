// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'person_type.dart';

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
