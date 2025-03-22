part of '../../../data.dart';

@DataClassName('UserDetailsData')
class UserDetailsTable extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get uid => text().nullable().unique()();
  IntColumn get person => integer().nullable().references(PersonTable, #id)();
  TextColumn get nickName => text().nullable()();
  TextColumn get userName => text().unique()();
  TextColumn get email => text().nullable().unique()();
  TextColumn get phoneNumber => text().nullable()();
  BoolColumn get isActive => boolean()();
  BoolColumn get isAuthenticated => boolean()();
  BoolColumn get isEmailVerified => boolean()();
  BoolColumn get isPhoneNumberVerified => boolean()();
  TextColumn get encryptedPassword => text().nullable()();
  BoolColumn get isCompletedFirstSetup => boolean().nullable()();
  IntColumn get setupLevel => integer().nullable()();
  DateTimeColumn get expirationDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

extension UserDataExtension on UserDetailsData {
  UserDetailsEntity toEntity() => UserDetailsEntity(
        id: id??0,
        uid: uid,
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
}

extension UserDetailsEntityExtension on UserDetailsEntity {
  UserDetailsData toData() => UserDetailsData(
        id: id,
        uid: uid,
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
}