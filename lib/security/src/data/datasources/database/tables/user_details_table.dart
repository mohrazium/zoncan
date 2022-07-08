import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';

part 'user_details_table.g.dart';

@Entity()
@JsonSerializable()
class UserDetailsTable {
  @Id()
  int id;
  @Unique()
  late final String? uid;
  final String? nickName;
  @Unique()
  final String userName;
  @Unique()
  final String? email;
  final String? phoneNumber;
  final bool isActive;
  final bool isEmailVerified;
  final bool isPhoneNumberVerified;
  final String encryptedPassword;
  @Property(type: PropertyType.date)
  final DateTime? createdAt;
  @Property(type: PropertyType.date)
  final DateTime? updatedAt;

  UserDetailsTable({
    this.id = 0,
    this.uid,
    this.nickName,
    required this.userName,
    this.email,
    this.phoneNumber,
    this.isActive = true,
    this.isEmailVerified = false,
    this.isPhoneNumberVerified = false,
    required this.encryptedPassword,
    this.createdAt,
    this.updatedAt,
  }) {
    this.uid = uid ?? const Uuid().v4().toString();
  }

  @override
  String toString() {
    return 'UserDetailsTable(id: $id, uid: $uid, nickName: $nickName, userName: $userName, email: $email, phoneNumber: $phoneNumber, isActive: $isActive, isEmailVerified: $isEmailVerified, isPhoneNumberVerified: $isPhoneNumberVerified, encryptedPassword: $encryptedPassword, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory UserDetailsTable.fromJson(String jsonString) =>
      _$UserDetailsTableFromJson(json.decode(jsonString));

  String toJson() => json.encode(_$UserDetailsTableToJson(this));
}
