part of '../data.dart';

@MappableClass(
    generateMethods: GenerateMethods.copy |
        GenerateMethods.equals |
        GenerateMethods.stringify |
        GenerateMethods.decode |
        GenerateMethods.encode)
class PersonModel extends PersonEntity with PersonModelMappable {
  PersonModel({
    required super.id,
    super.uid,
    required super.name,
    required super.family,
    super.fatherName,
    super.birthDate,
    super.nationalCode,
    super.phoneNumber,
    super.phoneNumberSms,
    super.telephone,
    super.email,
    super.economicCode,
    super.profilePicture,
    required super.address,
    required super.accountingInfo,
    required super.personType,
    super.description,
    super.createdAt,
    super.updatedAt,
  });

  factory PersonModel.init() => PersonModel(
        id: 0,
        name: "",
        family: "",
        address: AddressModel.init(),
        accountingInfo: AccountingInfoModel.init(),
        personType: 0,
      );

  factory PersonModel.fromTable(PersonTable table) =>
      PersonModel.fromJson(table.toJson());

  PersonTable toTable() => PersonTable.fromJson(toJson());
}
