// ignore_for_file: overridden_fields

part of '../../data.dart';

@Entity()
@JsonSerializable()
class UserDetailsTable implements UserDetailsEntity {
  @override
  @Id()
  int id;
  @override
  @Unique()
  final String? uid;
  @override
  final String? nickName;
  @override
  @Unique()
  final String userName;
  @override
  @Unique()
  final String? email;
  @override
  final String? phoneNumber;
  @override
  final bool isActive;
  @override
  final bool isAuthenticated;
  @override
  final bool isEmailVerified;
  @override
  final bool isPhoneNumberVerified;
  @override
  final String encryptedPassword;
  @override
  final bool? isCompletedFirstSetup;
  @override
  final int? setupLevel;
  @override
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  final DateTime? expirationDate;
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

  @override
  String toString() {
    return 'UserDetailsTable(id: $id, uid: $uid, nickName: $nickName, userName: $userName, email: $email, phoneNumber: $phoneNumber, isActive: $isActive, isAuthenticated: $isAuthenticated, isEmailVerified: $isEmailVerified, isPhoneNumberVerified: $isPhoneNumberVerified, encryptedPassword: $encryptedPassword, isCompletedFirstSetup: $isCompletedFirstSetup, setupLevel: $setupLevel, expirationDate: $expirationDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory UserDetailsTable.fromJson(String jsonString) =>
      _$UserDetailsTableFromJson(json.decode(jsonString));

  String toJson() => json.encode(_$UserDetailsTableToJson(this));
}
