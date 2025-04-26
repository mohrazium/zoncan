import 'package:dart_mappable/dart_mappable.dart';
import 'package:zoncan/features/accounts/data/models/person_model.dart';
import 'package:zoncan/features/accounts/data/models/user_details_model.dart';
import 'package:zoncan/features/accounts/domain/entity/user_details_entity.dart';

part 'user_details_model.mapper.dart';

typedef UserDetails = UserDetailsModelMapper;

@MappableClass(
    generateMethods: GenerateMethods.copy |
        GenerateMethods.equals |
        GenerateMethods.stringify |
        GenerateMethods.decode |
        GenerateMethods.encode)
class UserDetailsModel with UserDetailsModelMappable {
  final int? id;
  final String? uid;
  final PersonModel? person;
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

  UserDetailsModel(
      {this.id,
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

  factory UserDetailsModel.init() => UserDetailsModel(
      userName: "",
      isActive: false,
      isAuthenticated: false,
      isEmailVerified: false,
      isPhoneNumberVerified: false);

      factory UserDetailsModel.fromEntity(UserDetailsEntity entity) => UserDetailsModel(
        uid: entity.uid,
        person: entity.person != null ? PersonModel.fromEntity(entity.person!) : null,
        nickName: entity.nickName,
        userName: entity.userName,
        email: entity.email,
        phoneNumber: entity.phoneNumber,
        isActive: entity.isActive,
        isAuthenticated: entity.isAuthenticated,
        isEmailVerified: entity.isEmailVerified,
        isPhoneNumberVerified: entity.isPhoneNumberVerified,
        encryptedPassword: entity.encryptedPassword,
        isCompletedFirstSetup: entity.isCompletedFirstSetup,
        setupLevel: entity.setupLevel,
        expirationDate: entity.expirationDate,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
      UserDetailsEntity toEntity() => UserDetailsEntity(
      uid: uid,
      person: person?.toEntity(),
      nickName: nickName,
      userName: userName,
      email: email,
      phoneNumber: phoneNumber,
      isActive: isActive,
      isAuthenticated: isAuthenticated,
      isEmailVerified: isEmailVerified,
      isPhoneNumberVerified: isPhoneNumberVerified,
      encryptedPassword: encryptedPassword,
      isCompletedFirstSetup: isCompletedFirstSetup,
      setupLevel: setupLevel,
      expirationDate: expirationDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );

    bool get isEmpty => userName ==""&&!isActive&&!isAuthenticated&&!isEmailVerified&&!isPhoneNumberVerified ;
}
