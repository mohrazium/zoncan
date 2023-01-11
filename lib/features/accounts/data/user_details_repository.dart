part of zoncan.features.accounts.data;

abstract class UserDetailsRepository extends Storing<int, UserDetailsTable> {
  Future<UserDetailsTable?> findByUUID(String uuid);
  Future<UserDetailsTable?> findByEmail(String email);
  Future<UserDetailsTable?> findByUsername(String username);
}

class UserDetailsRepositoryImpl implements UserDetailsRepository {
  @override
  Future<Box<UserDetailsTable>> get storeBox async =>
      await Modular.getAsync<ZoncanDatabase>()
          .then((db) => db.store.box<UserDetailsTable>())
          .onError((error, stackTrace) => throw FailureException(
                level: ExceptionLevel.ERROR,
                type: ExceptionType.CantCREATE,
                message:
                    "Can't create user details box in user details repository.",
                error: error,
                stackTrace: stackTrace,
              ));

  @override
  Future<bool> delete(UserDetailsTable table) async {
    return await storeBox
        .then((box) {
          if (table.id != 0) {
            if (box.get(table.id) != null) {
              return box;
            } else {
              throw FailureException(
                level: ExceptionLevel.ERROR,
                type: ExceptionType.NotFOUND,
                message: "User not found by id : ${table.id}",
              );
            }
          } else {
            throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.NotVALID,
              message: "Not valid user details.",
            );
          }
        })
        .then((validBox) => validBox.remove(table.id))
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.CantDELETE,
              message: "Can't delete user.",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<int> deleteAll() async {
    return await storeBox
        .then((box) => box.removeAll())
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.CantDELETE,
              message: "Can't delete all users.",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<List<UserDetailsTable?>> findAll() async {
    return await storeBox
        .then((box) => box.getAll())
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.NotFOUND,
              message: "Can't find all users.",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<UserDetailsTable?> findById(int id) async {
    return await storeBox
        .then((box) => box.get(id))
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.NotFOUND,
              message: "Can't find user by id $id",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<List<UserDetailsTable?>> findByIds(List<int> ids) async {
    return await storeBox
        .then((box) => box.getMany(ids))
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.NotFOUND,
              message: "Can't find users by this id's $ids",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<int?> save(UserDetailsTable table) async {
    return await storeBox
        .then((box) async => await box.putAsync(table, mode: PutMode.insert))
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.CantCREATE,
              message: "Can't save this user :${table.toString()}",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<List<int>> saveAll(List<UserDetailsTable> tables) async {
    return await storeBox
        .then((box) async => box.putMany(tables, mode: PutMode.insert))
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.CantCREATE,
              message: "Can't save all users :${tables.toString()}",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<int> saveQueued(UserDetailsTable table) async {
    return await storeBox
        .then((box) async => box.putQueued(table, mode: PutMode.insert))
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.CantCREATE,
              message: "Can't save user in queue :${table.toString()}",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<bool> update(UserDetailsTable table) async {
    return await storeBox
        .then((box) async => await box.putAsync(table, mode: PutMode.update))
        .then((updatedUserId) async {
      return updatedUserId == table.id
          ? true
          : throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.CantUPDATE,
              message: "Can't update this user :${table.toString()}",
            );
    }).onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.CantUPDATE,
              message: "Can't update user in queue :${table.toString()}",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<UserDetailsTable?> findByEmail(String email) async {
    return await storeBox.then((box) {
      Query<UserDetailsTable> query =
          box.query(UserDetailsTable_.email.equals(email)).build();
      return query.findUnique();
    }).onError((error, stackTrace) => throw FailureException(
          level: ExceptionLevel.ERROR,
          type: ExceptionType.NotFOUND,
          message: "Can't find user by email :$email",
          error: error,
          stackTrace: stackTrace,
        ));
  }

  @override
  Future<UserDetailsTable?> findByUUID(String uuid) async {
    return await storeBox.then((box) {
      Query<UserDetailsTable> query =
          box.query(UserDetailsTable_.uid.equals(uuid)).build();
      return query.findUnique();
    }).onError((error, stackTrace) => throw FailureException(
          level: ExceptionLevel.ERROR,
          type: ExceptionType.NotFOUND,
          message: "Can't find user by uuid :$uuid",
          error: error,
          stackTrace: stackTrace,
        ));
  }

  @override
  Future<UserDetailsTable?> findByUsername(String username) async {
    return await storeBox.then((box) {
      Query<UserDetailsTable> query =
          box.query(UserDetailsTable_.userName.equals(username)).build();
      return query.findUnique();
    }).onError((error, stackTrace) => throw FailureException(
          level: ExceptionLevel.ERROR,
          type: ExceptionType.NotFOUND,
          message: "Can't find user by username :$username",
          error: error,
          stackTrace: stackTrace,
        ));
  }
  // For api integration declare ds here
  // like: final UserDetailsClient _client;
}
