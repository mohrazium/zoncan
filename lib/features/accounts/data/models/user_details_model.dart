part of '../data.dart';

typedef UserDetails = UserDetailsModelMapper;

@MappableClass(
    generateMethods: GenerateMethods.copy |
        GenerateMethods.equals |
        GenerateMethods.stringify |
        GenerateMethods.decode |
        GenerateMethods.encode)
class UserDetailsModel extends UserDetailsEntity with UserDetailsModelMappable {
  UserDetailsModel(
      {required super.id,
      super.uid,
      super.person,
      super.nickName,
      required super.userName,
      super.email,
      super.phoneNumber,
      required super.isActive,
      required super.isAuthenticated,
      required super.isEmailVerified,
      required super.isPhoneNumberVerified,
      super.encryptedPassword,
      super.isCompletedFirstSetup,
      super.setupLevel,
      super.expirationDate,
      super.createdAt,
      super.updatedAt});

  factory UserDetailsModel.init() => UserDetailsModel(
      id: 0,
      userName: "",
      isActive: false,
      isAuthenticated: false,
      isEmailVerified: false,
      isPhoneNumberVerified: false);

  factory UserDetailsModel.fromTable(UserDetailsTable table) {
    return UserDetailsModel(
      id: table.id,
      uid: table.uid,
      person: PersonModel.fromTable(table.person!),
      nickName: table.nickName,
      userName: table.userName,
      phoneNumber: table.phoneNumber,
      email: table.email,
      isActive: table.isActive,
      isAuthenticated: table.isAuthenticated,
      isEmailVerified: table.isEmailVerified,
      isPhoneNumberVerified: table.isPhoneNumberVerified,
      encryptedPassword: table.encryptedPassword,
      isCompletedFirstSetup: table.isCompletedFirstSetup,
      setupLevel: table.setupLevel,
      expirationDate: table.expirationDate,
      createdAt: table.createdAt,
      updatedAt: table.updatedAt,
    );
  }

  UserDetailsTable toTable() {
    return UserDetailsTable(
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
        this.updatedAt);
  }
}
