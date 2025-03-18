// ignore_for_file: overridden_fields

part of '../../data.dart';

@Entity()
@JsonSerializable()
class UserDetailsTable {
  @Id()
  int id;
  @Unique()
  String? uid;
  @Transient()
  PersonTable? get person => _person.target;
  final ToOne<PersonTable> _person = ToOne<PersonTable>();
  String? nickName;
  @Unique()
  String userName;
  @Unique()
  String? email;
  String? phoneNumber;
  bool isActive;
  bool isAuthenticated;
  bool isEmailVerified;
  bool isPhoneNumberVerified;
  String? encryptedPassword;
  bool? isCompletedFirstSetup;
  int? setupLevel;
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  final DateTime? expirationDate;
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  final DateTime? createdAt;
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  final DateTime? updatedAt;

  UserDetailsTable(
    this.id,
    this.uid,
    this.nickName,
    this.userName,
    this.email,
    this.phoneNumber,
    this.isActive,
    this.isAuthenticated,
    this.isEmailVerified,
    this.isPhoneNumberVerified,
    this.encryptedPassword,
    this.isCompletedFirstSetup,
    this.setupLevel,
    this.expirationDate,
    this.createdAt,
    this.updatedAt,
  );
  factory UserDetailsTable.fromJson(String jsonString) =>
      _$UserDetailsTableFromJson(json.decode(jsonString));

  String toJson() => json.encode(_$UserDetailsTableToJson(this));
}
