// ignore_for_file: overridden_fields

part of '../../data.dart';

@Entity()
@JsonSerializable()
class PersonTable extends PersonEntity {
  @override
  @Id()
   int id;
  @override
  @Unique()
  final String? uid;
  @override
  final String name;
  @override
  final String family;
  @override
  final String? fatherName;
  @override
  final DateTime? birthDate;
  @override
  final int? nationalCode;
  @override
  final String? phoneNumber;
  @override
  final String? phoneNumberSms;
  @override
  final String? telephone;
  @override
  final String? email;
  @override
  final String? economicCode;
  @override
  final String? profilePicture;
  @override
  final ToOne<AddressTable> address;
  @override
  final ToOne<AccountingInfoTable> accountingInfo;
  @override
  int personType;
  @override
  final String? description;
  @override
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  final DateTime? createdAt;
  @override
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  final DateTime? updatedAt;

  PersonTable({
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
  }) : super(
          id: id,
          uid: uid,
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
          address: address,
          accountingInfo: accountingInfo,
          personType: personType,
          description: description,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory PersonTable.fromJson(String jsonString) =>
      _$PersonTableFromJson(json.decode(jsonString));

  String toJson() => json.encode(_$PersonTableToJson(this));
}
