
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/features/accounts/data/datasource/local/tables/user_details_table.dart';

part 'user_details_dao.g.dart';

@Injectable()
@DriftAccessor(tables: [UserDetailsTable])
class UserDetailsDao extends DatabaseAccessor<ZoncanDatabase>
    with _$UserDetailsDaoMixin {
  UserDetailsDao(super.db);
 // Create new user in db
  Future<UserDetailsData?> insert(UserDetailsData user) => into(
        userDetailsTable,
      )
      .insert(user)
      .then(
        (savedId) =>
            (select(userDetailsTable)
              ..where((table) => table.uid.equals(user.uid))).getSingleOrNull(),
      );
  // Get user by uid from db
  Future<UserDetailsData?> getUser(String uuid) =>
      (select(userDetailsTable)
        ..where((t) => t.uid.equals(uuid))).getSingleOrNull();
  // Get user by email from db
  Future<UserDetailsData?> getUserByEmail(String email) =>
      (select(userDetailsTable)
        ..where((t) => t.email.equals(email))).getSingleOrNull();
  // Get user by email from db
  Future<UserDetailsData?> getUserByUsername(String username) =>
      (select(userDetailsTable)
        ..where((t) => t.userName.equals(username))).getSingleOrNull();
  // Delete user from db
  Future<bool> deleteUser(UserDetailsData data) async => await (delete(userDetailsTable)
    ..where(
      (t) => t.uid.equals(data.uid),
    )).go().then((deletedValue) => deletedValue == 1);
  // Update user in db
  Future<UserDetailsData?> updateUser(UserDetailsData data) async =>
      await update(userDetailsTable).replace(data).then((isUpdated) {
        if (isUpdated) {
          return (select(userDetailsTable)..where(
            (updated) => updated.uid.equals(data.uid),
          )).getSingleOrNull();
        }
        return null;
      });
  // Get all user from db
  Future<List<UserDetailsData?>> get getAllUser =>
      select(userDetailsTable).get();
}
