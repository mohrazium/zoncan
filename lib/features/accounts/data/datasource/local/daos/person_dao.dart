part of '../../../data.dart';

@Injectable()
@DriftAccessor(tables: [PersonTable])
class PersonDao extends DatabaseAccessor<ZoncanDatabase> with _$PersonDaoMixin {
  PersonDao(super.db);

  Future<PersonData?> getPerson(int id) => (select(personTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> insertPerson(PersonData person) => into(personTable).insert(person);

  Future<void> updatePerson(PersonData person) => update(personTable).replace(person);

  Future<void> deletePerson(int id) => (delete(personTable)..where((t) => t.id.equals(id))).go();
}