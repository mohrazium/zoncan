part of '../../../data.dart';

@DataClassName('PersonData')
class PersonTable extends Table {
  TextColumn get uid => text()();
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
  TextColumn get addressId => text().nullable().references(AddressTable, #uid)();
  TextColumn get accountingInfoId =>
      text().nullable().references(AccountingInfoTable, #uid)();
  IntColumn get personType => integer()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
 @override
  Set<Column> get primaryKey => {uid};
  
}

extension PersonDataExtension on PersonData {
  PersonEntity toEntity({
    required AddressEntity address,
    required AccountingInfoEntity accountingInfo,
  }) =>
      PersonEntity(
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
    required String addressId,
    required String accountingInfoId,
  }) =>
      PersonData(
        uid: uid ?? Uuid().v4(),
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
