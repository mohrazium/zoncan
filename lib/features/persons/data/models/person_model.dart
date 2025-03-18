part of '../data.dart';

typedef PersonMapper = PersonModelMapper;

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
    super.address,
    super.accountingInfo,
    super.personType,
    super.description,
    super.createdAt,
    super.updatedAt,
  });

  factory PersonModel.init() => PersonModel(id: 0, name: "", family: "");

  factory PersonModel.fromTable(PersonTable table) {
    return PersonModel(
      id: table.id,
      uid: table.uid,
      name: table.name,
      family: table.family,
      fatherName: table.fatherName,
      birthDate: table.birthDate,
      nationalCode: table.nationalCode,
      phoneNumber: table.phoneNumber,
      phoneNumberSms: table.phoneNumberSms,
      telephone: table.telephone,
      email: table.email,
      economicCode: table.economicCode,
      profilePicture: table.profilePicture,
      personType:
          PersonType.values.firstWhere((e) => e.code == table._personTypeCode),
      description: table.description,
      createdAt: table.createdAt,
      updatedAt: table.updatedAt,
    );
  }

  PersonTable toTable() {
    return PersonTable(
      id: this.id,
      uid: this.uid,
      name: this.name,
      family: this.family,
      fatherName: this.fatherName,
      birthDate: this.birthDate,
      nationalCode: this.nationalCode,
      phoneNumber: this.phoneNumber,
      phoneNumberSms: this.phoneNumberSms,
      telephone: this.telephone,
      email: this.email,
      economicCode: this.economicCode,
      profilePicture: this.profilePicture,
      personTypeCode: this.personType.code, // تبدیل enum به int
      description: this.description,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
    );
  }
}
