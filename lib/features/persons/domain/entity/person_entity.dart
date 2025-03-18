part of '../domain.dart';

abstract class PersonEntity {
  int id;
  String? uid;
  UserDetailsEntity? userDetails;
  String name;
  String family;
  String? fatherName;
  DateTime? birthDate;
  int? nationalCode;
  String? phoneNumber;
  String? phoneNumberSms;
  String? telephone;
  String? email;
  String? economicCode;
  String? profilePicture;
  AddressEntity? address;
  AccountingInfoEntity? accountingInfo;
  PersonType personType;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  PersonEntity({
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
    this.personType = PersonType.all,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
}