part of '../data.dart';

typedef PersonMapper = PersonModelMapper;

@MappableClass(
    generateMethods: GenerateMethods.copy |
        GenerateMethods.equals |
        GenerateMethods.stringify |
        GenerateMethods.decode |
        GenerateMethods.encode)
class PersonModel with PersonModelMappable {
  final int id;
  final String? uid;
  final UserDetailsModel? userDetails;
  final String name;
  final String family;
  final String? fatherName;
  final DateTime? birthDate;
  final int? nationalCode;
  final String? phoneNumber;
  final String? phoneNumberSms;
  final String? telephone;
  final String? email;
  final String? economicCode;
  final String? profilePicture;
  final AddressModel? address;
  final AccountingInfoModel? accountingInfo;
  final PersonType? personType;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PersonModel({
    required this.id,
    this.uid,
    this.userDetails,
    required this.name,
    required this.family,
    this.fatherName,
    this.birthDate,
    this.nationalCode,
    this.phoneNumber,
    this.phoneNumberSms,
    this.telephone,
    this.email,
    this.economicCode,
    this.profilePicture,
    this.address,
    this.accountingInfo,
    this.personType,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory PersonModel.init() => PersonModel(id: 0, name: "", family: "");

  factory PersonModel.fromEntity(PersonEntity entity) => PersonModel(
        id: entity.id,
        uid: entity.uid,
        userDetails: entity.userDetails != null
            ? UserDetailsModel.fromEntity(entity.userDetails!)
            : null,
        name: entity.name,
        family: entity.family,
        fatherName: entity.fatherName,
        birthDate: entity.birthDate,
        nationalCode: entity.nationalCode,
        phoneNumber: entity.phoneNumber,
        phoneNumberSms: entity.phoneNumberSms,
        telephone: entity.telephone,
        email: entity.email,
        economicCode: entity.economicCode,
        profilePicture: entity.profilePicture,
        address: entity.address != null
            ? AddressModel.fromEntity(entity.address!)
            : null,
        accountingInfo: entity.accountingInfo != null
            ? AccountingInfoModel.fromEntity(entity.accountingInfo!)
            : null,
        personType: entity.personType,
        description: entity.description,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

      PersonEntity toEntity() => PersonEntity(
      id: id,
      uid: uid,
      userDetails: userDetails?.toEntity(),
      name: name,
      family: family,
      fatherName: fatherName,
      birthDate: birthDate,
      nationalCode: nationalCode,
      phoneNumber: phoneNumber,
      phoneNumberSms: phoneNumberSms,
      telephone: telephone,
      email: email,
      economicCode: economicCode,
      profilePicture: profilePicture,
      address: address?.toEntity(),
      accountingInfo: accountingInfo?.toEntity(),
      personType: personType,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
}
