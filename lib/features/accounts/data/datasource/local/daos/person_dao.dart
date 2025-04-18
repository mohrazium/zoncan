part of '../../../data.dart';

@Injectable()
@DriftAccessor(tables: [PersonTable])
class PersonDao extends DatabaseAccessor<ZoncanDatabase> with _$PersonDaoMixin {
  PersonDao(super.db);

  Future<PersonData?> getPerson(String uid) => (select(personTable)..where((t) => t.uid.equals(uid))).getSingleOrNull();

  Future<void> insertPerson(PersonData person) => into(personTable).insert(person);

  Future<void> updatePerson(PersonData person) => update(personTable).replace(person);

  Future<void> deletePerson(String uid) => (delete(personTable)..where((t) => t.uid.equals(uid))).go();
}