
import '../enums/person_type.dart';
import 'accounting_info_entity.dart';
import 'address_entity.dart';
import 'user_details_entity.dart';

class PersonEntity {
  final String? uid;
  final UserDetailsEntity? userDetails;
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
  final AddressEntity? address;
  final AccountingInfoEntity? accountingInfo;
  final PersonType? personType;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PersonEntity({
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
