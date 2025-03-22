part of '../../../data.dart';

@DataClassName('PersonData')
class PersonTable extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get uid => text().nullable().unique()();
  TextColumn get name => text()();
  TextColumn get family => text()();
  TextColumn get fatherName => text().nullable()();
  DateTimeColumn get birthDate => dateTime().nullable()();
  IntColumn get nationalCode => integer().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get phoneNumberSms => text().nullable()();
  TextColumn get telephone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get economicCode => text().nullable()();
  TextColumn get profilePicture => text().nullable()();
  IntColumn get addressId => integer().references(AddressTable, #id)();
  IntColumn get accountingInfoId =>
      integer().references(AccountingInfoTable, #id)();
  IntColumn get personType => integer()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
 @override
  Set<Column> get primaryKey => {id};
  
}

extension PersonDataExtension on PersonData {
  PersonEntity toEntity({
    required AddressEntity address,
    required AccountingInfoEntity accountingInfo,
  }) =>
      PersonEntity(
        id: id??0,
        uid: uid,
        name: name,
        family: family,
        fatherName: fatherName,
        birthDate: birthDate,
        nationalCode: nationalCode,
        phoneNumber: phoneNumber,
        phoneNumberSms: phoneNumberSms,
        telephone: telephone,
        email: email,
        economicCode: economicCode,
        profilePicture: profilePicture,
        address: address,
        accountingInfo: accountingInfo,
        personType: PersonType.values.firstWhere((e) => e.code == personType),
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension PersonEntityExtension on PersonEntity {
  PersonData toData({
    required int addressId,
    required int accountingInfoId,
  }) =>
      PersonData(
        id: id,
        uid: uid,
        name: name,
        family: family,
        fatherName: fatherName,
        birthDate: birthDate,
        nationalCode: nationalCode,
        phoneNumber: phoneNumber,
        phoneNumberSms: phoneNumberSms,
        telephone: telephone,
        email: email,
        economicCode: economicCode,
        profilePicture: profilePicture,
        addressId: addressId,
        accountingInfoId: accountingInfoId,
        personType: personType?.code ?? 1,
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
