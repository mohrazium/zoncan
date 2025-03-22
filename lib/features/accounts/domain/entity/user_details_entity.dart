part of '../domain.dart';

 class UserDetailsEntity {
  int? id;
  String? uid;
  PersonEntity? person;
  String? nickName;
  String userName;
  String? email;
  String? phoneNumber;
  bool isActive;
  bool isAuthenticated;
  bool isEmailVerified;
  bool isPhoneNumberVerified;
  String? encryptedPassword;
  bool? isCompletedFirstSetup;
  int? setupLevel;
  DateTime? expirationDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserDetailsEntity(
      { this.id,
      this.uid,
      this.person,
      this.nickName,
      required this.userName,
      this.email,
      this.phoneNumber,
      required this.isActive,
      required this.isAuthenticated,
      required this.isEmailVerified,
      required this.isPhoneNumberVerified,
      this.encryptedPassword,
      this.isCompletedFirstSetup,
      this.setupLevel,
      this.expirationDate,
      this.createdAt,
      this.updatedAt});
}
