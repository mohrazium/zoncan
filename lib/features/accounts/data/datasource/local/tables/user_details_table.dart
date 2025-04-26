
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/features/accounts/domain/entity/user_details_entity.dart';

import 'person_table.dart';


@DataClassName('UserDetailsData')
class UserDetailsTable extends Table {
  TextColumn get uid => text()();
  TextColumn get person => text().nullable().references(PersonTable, #uid)();
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
  Set<Column> get primaryKey => {uid};
}

extension UserDataExtension on UserDetailsData {
  UserDetailsEntity toEntity() => UserDetailsEntity(
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
        uid: uid ?? Uuid().v4(),
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