part of '../../../data.dart';

@Injectable()
@DriftAccessor(tables: [UserDetailsTable])
class UserDetailsDao extends DatabaseAccessor<ZoncanDatabase>
    with _$UserDetailsDaoMixin {
  UserDetailsDao(super.db);

  Future<UserDetailsData?> insert(UserDetailsData user) =>
      into(userDetailsTable).insert(user).then((savedId) =>
          (select(userDetailsTable)..where((table) => table.id.equals(savedId)))
              .getSingleOrNull());
  Future<UserDetailsData?> getUserByUUID(String uuid) =>
      (select(userDetailsTable)..where((t) => t.uid.equals(uuid)))
          .getSingleOrNull();
  Future<UserDetailsData?> getUserByEmail(String email) =>
      (select(userDetailsTable)..where((t) => t.email.equals(email)))
          .getSingleOrNull();
  Future<UserDetailsData?> getUserByUsername(String username) =>
      (select(userDetailsTable)..where((t) => t.userName.equals(username)))
          .getSingleOrNull();
  Future<bool> deleteUser(int id) async =>
      await (delete(userDetailsTable)..where((t) => t.id.equals(id)))
          .go()
          .then((deletedValue) => deletedValue == 1);
  Future<bool> deleteUserByUUID(String uuid) async =>
      await (delete(userDetailsTable)..where((t) => t.uid.equals(uuid)))
          .go()
          .then((deletedValue) => deletedValue == 1);
  Future<UserDetailsData?> updateUser(UserDetailsData data) async =>
      await update(userDetailsTable).replace(data).then((isUpdated) {
        if (isUpdated) {
          return (select(userDetailsTable)
                ..where((updated) => updated.id.equals(data.id!)))
              .getSingleOrNull();
        }
        return null;
      });
  Future<UserDetailsData?> updateUserByUUID(String uuid) async {
    UserDetailsData? foundedUser = await (select(userDetailsTable)
          ..where((user) => user.uid.equals(uuid)))
        .getSingleOrNull();
    if (foundedUser != null) {
      return await update(userDetailsTable)
          .replace(foundedUser)
          .then((isUpdated) {
        if (isUpdated) {
          return (select(userDetailsTable)
                ..where((updated) => updated.uid.equals(uuid)))
              .getSingleOrNull();
        }
        return null;
      });
    } else {
      return null;
    }
  }

  Future<List<UserDetailsData?>> get getAllUser =>
      select(userDetailsTable).get();
}
