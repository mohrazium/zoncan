
 import 'person_entity.dart';

class UserDetailsEntity {
 final String? uid;
 final PersonEntity? person;
 final String? nickName;
 final String userName;
 final String? email;
 final String? phoneNumber;
 final bool isActive;
 final bool isAuthenticated;
 final bool isEmailVerified;
 final bool isPhoneNumberVerified;
 final String? encryptedPassword;
 final bool? isCompletedFirstSetup;
 final int? setupLevel;
 final DateTime? expirationDate;
 final DateTime? createdAt;
 final DateTime? updatedAt;

  UserDetailsEntity(
      {
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
