part of '../domain.dart';

abstract class PersonEntity {
  final int id;
  final String? uid;
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
  final dynamic address;
  final dynamic accountingInfo;
  final int personType;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PersonEntity({
    required this.id,
    this.uid,
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
    required this.address,
    required this.accountingInfo,
    required this.personType,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
}
