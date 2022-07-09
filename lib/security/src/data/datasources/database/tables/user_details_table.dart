import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:zoncan/common/common.dart' show DateTimeEpochConverter;

part 'user_details_table.g.dart';

@Entity()
@JsonSerializable()
class UserDetailsTable {
  @Id()
  int id;
  @Unique()
  final String? uid;
  final String? nickName;
  @Unique()
  final String userName;
  @Unique()
  final String? email;
  final String? phoneNumber;
  final bool isActive;
  final bool isAuthenticated;
  final bool isEmailVerified;
  final bool isPhoneNumberVerified;
  final String encryptedPassword;
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

  UserDetailsTable({
    this.id = 0,
    this.uid,
    this.nickName,
    required this.userName,
    this.email,
    this.phoneNumber,
    this.isActive = true,
    this.isAuthenticated = false,
    this.isEmailVerified = false,
    this.isPhoneNumberVerified = false,
    required this.encryptedPassword,
    this.expirationDate,
    this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'UserDetailsTable(id: $id, uid: $uid, nickName: $nickName, userName: $userName, email: $email, phoneNumber: $phoneNumber, isActive: $isActive, isAuthenticated: $isAuthenticated, isEmailVerified: $isEmailVerified, isPhoneNumberVerified: $isPhoneNumberVerified, encryptedPassword: $encryptedPassword, expirationDate: $expirationDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory UserDetailsTable.fromJson(String jsonString) =>
      _$UserDetailsTableFromJson(json.decode(jsonString));

  String toJson() => json.encode(_$UserDetailsTableToJson(this));
}
