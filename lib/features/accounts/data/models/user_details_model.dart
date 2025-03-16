part of '../data.dart';

typedef UserModel = UserDetailsModelMapper;

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

  factory UserDetailsModel.fromTable(UserDetailsTable table) =>
      UserModel.fromJson(table.toJson());

  UserDetailsTable toTable() => UserDetailsTable.fromJson(toJson());
}
