
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/features/accounts/domain/entity/address_entity.dart';


@DataClassName('AddressData')
class AddressTable extends Table {
  TextColumn get uid => text()();
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
  Set<Column> get primaryKey => {uid};
}

extension AddressDataExtension on AddressData {
  AddressEntity toEntity() => AddressEntity(
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
        uid: uid ?? Uuid().v4(),
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