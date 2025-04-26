import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path show join;
import 'package:path_provider/path_provider.dart';
import 'package:zoncan/features/accounts/data/datasource/local/daos/person_dao.dart';
import 'package:zoncan/features/accounts/data/datasource/local/daos/user_details_dao.dart';
import 'package:zoncan/features/accounts/data/datasource/local/tables/accounting_info_table.dart';
import 'package:zoncan/features/accounts/data/datasource/local/tables/address_table.dart';
import 'package:zoncan/features/accounts/data/datasource/local/tables/person_table.dart';
import 'package:zoncan/features/accounts/data/datasource/local/tables/user_details_table.dart';

import '../auditor/audit_table.dart';
import '../auditor/auditor_dao.dart';
import 'drift_serializer.dart';
part 'zoncan_database.g.dart';

@DriftDatabase(
  tables: [
    AuditTable,
    UserDetailsTable,
    PersonTable,
    AddressTable,
    AccountingInfoTable,
  ],
  daos: [AuditorDAO, UserDetailsDao, PersonDao],
)
@LazySingleton()
class ZoncanDatabase extends _$ZoncanDatabase {
  ZoncanDatabase() : super(_openConnection());

  // Lazy connection setup to resolve the database file path
  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbFile = File(path.join(dbFolder.path, 'zoncan_database.sqlite'));
      return NativeDatabase(dbFile);
    });
  }

  // Access DAOs directly
  AuditorDAO get audit => auditorDAO;
  UserDetailsDao get userDetails => userDetailsDao;
  PersonDao get person => personDao;

  // Expose database file for debugging or manual access
  Future<File> get databaseFile async {
    final dbFolder = await getApplicationDocumentsDirectory();
    return File(path.join(dbFolder.path, 'zoncan_database.sqlite'));
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      driftRuntimeOptions.defaultSerializer = const DefaultMapValueSerializer();
    },
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      await customStatement(
        'PRAGMA foreign_keys = OFF',
      ); // Disable foreign keys before migrations

      await transaction(() async {
        // Add your migration logic here if needed
        // Example:
        // if (from < 2) {
        //   m.addColumn(soldierCaseTable, soldierCaseTable.dispatcher);
        // }
      });

      // Assert schema validity after migrations (optional)
      // final wrongForeignKeys = await customSelect('PRAGMA foreign_key_check').get();
      // assert(wrongForeignKeys.isEmpty, "${wrongForeignKeys.map((e) => e.data)}");
    },
  );
}
