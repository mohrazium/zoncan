
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/features/accounts/data/datasource/local/tables/person_table.dart';

part 'person_dao.g.dart';

@Injectable()
@DriftAccessor(tables: [PersonTable])
class PersonDao extends DatabaseAccessor<ZoncanDatabase> with _$PersonDaoMixin {
  PersonDao(super.db);

  Future<PersonData?> getPerson(String uid) => (select(personTable)..where((t) => t.uid.equals(uid))).getSingleOrNull();

  Future<void> insertPerson(PersonData person) => into(personTable).insert(person);

  Future<void> updatePerson(PersonData person) => update(personTable).replace(person);

  Future<void> deletePerson(String uid) => (delete(personTable)..where((t) => t.uid.equals(uid))).go();
}