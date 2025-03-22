part of '../../../data.dart';

@DataClassName('AddressData')
class AddressTable extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get uid => text().nullable().unique()();
  TextColumn get postalCode => text().nullable()();
  TextColumn get province => text().nullable()();
  TextColumn get county => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get blv => text().nullable()();
  TextColumn get fullAddress => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
 @override
  Set<Column> get primaryKey => {id};
}

extension AddressDataExtension on AddressData {
  AddressEntity toEntity() => AddressEntity(
        id: id??0,
        uid: uid,
        postalCode: postalCode,
        province: province,
        county: county,
        city: city,
        blv: blv,
        fullAddress: fullAddress,
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension AddressEntityExtension on AddressEntity {
  AddressData toData() => AddressData(
        id: id,
        uid: uid,
        postalCode: postalCode,
        province: province,
        county: county,
        city: city,
        blv: blv,
        fullAddress: fullAddress,
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}