part of '../data.dart';

typedef UserModel = UserDetailsModelMapper;

@MappableClass(
    generateMethods: GenerateMethods.copy |
        GenerateMethods.equals |
        GenerateMethods.stringify |
        GenerateMethods.decode |
        GenerateMethods.encode)
class UserDetailsModel
    with UserDetailsModelMappable
    implements UserDetailsEntity {
  @override
  final int id;

  @override
  final String? uid;

  @override
  final String? nickName;

  @override
  final String userName;

  @override
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
  final String? encryptedPassword;
  @override
  final bool? isCompletedFirstSetup;
  @override
  final int? setupLevel;

  @override
  final DateTime? expirationDate;

  @override
  final DateTime? createdAt;

  @override
  final DateTime? updatedAt;

  UserDetailsModel(
      {required this.id,
        this.uid,
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
