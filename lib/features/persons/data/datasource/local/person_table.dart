// ignore_for_file: overridden_fields

part of '../../data.dart';

@Entity()
@JsonSerializable()
class PersonTable {
  @Id()
  int id;
  @Unique()
  String? uid;
  String name;
  String family;
  String? fatherName;
  @Property(type: PropertyType.date)
  DateTime? birthDate;
  int? nationalCode;
  String? phoneNumber;
  String? phoneNumberSms;
  String? telephone;
  String? email;
  @Transient()
  PersonType get personType =>
      PersonType.values.firstWhere((e) => e.code == _personTypeCode);

  @Property(type: PropertyType.int)
  final int _personTypeCode;
  @Transient()
  AddressTable? get address => _addressRel.target;
  final ToOne<AddressTable> _addressRel = ToOne<AddressTable>();
  @Transient()
  AccountingInfoTable? get accountingInfo => _accountingInfoRel.target;
  final ToOne<AccountingInfoTable> _accountingInfoRel =
      ToOne<AccountingInfoTable>();
  String? economicCode;
  String? profilePicture;
  String? description;
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  DateTime? updatedAt;
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
    int personTypeCode = 1,
    this.description,
    this.createdAt,
    this.updatedAt,
  })  : _personTypeCode = personTypeCode;


  factory PersonTable.fromJson(String jsonString) =>
      _$PersonTableFromJson(json.decode(jsonString));

  String toJson() => json.encode(_$PersonTableToJson(this));
}
