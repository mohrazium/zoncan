part of '../data.dart';

@Injectable(as: UserDetailsRepository)
class UserDetailsRepositoryImpl extends Storing<int, UserDetailsTable>
    implements UserDetailsRepository{
  @override
  Future<Box<UserDetailsTable>> get storeBox async {
    ZoncanDatabase database = Injection.serviceLocator.get<ZoncanDatabase>();
    return await database
        .zoncanObjectBoxDB
        .then((db) => db.objectBoxStore.box<UserDetailsTable>())
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.CantCREATE,
              message:
                  "Can't create user details box in user details repository.",
              error: error,
              stackTrace: stackTrace,
            ));
  }

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
  Future<UserDetailsModel?> findUserByEmail(String email) async {
    return await storeBox
        .then((box) {
          Query<UserDetailsTable> query =
              box.query(UserDetailsTable_.email.equals(email)).build();
          return query.findUnique();
        })
        .then((foundedUser) => foundedUser != null
            ? UserModel.fromJson(foundedUser.toJson())
            : null)
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.NotFOUND,
              message: "Can't find user by email :$email",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<UserDetailsModel?> findUserByUUID(String uuid) async {
    return await storeBox
        .then((box) {
          Query<UserDetailsTable> query =
              box.query(UserDetailsTable_.uid.equals(uuid)).build();
          return query.findUnique();
        })
        .then((foundedUser) => foundedUser != null
            ? UserModel.fromJson(foundedUser.toJson())
            : null)
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.NotFOUND,
              message: "Can't find user by uuid :$uuid",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<UserDetailsModel?> findUserByUsername(String username) async {
    return await storeBox
        .then((box) {
          Query<UserDetailsTable> query =
              box.query(UserDetailsTable_.userName.equals(username)).build();
          return query.findUnique();
        })
        .then((foundedUser) => foundedUser != null
            ? UserModel.fromJson(foundedUser.toJson())
            : null)
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.NotFOUND,
              message: "Can't find user by username :$username",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<bool> deleteUser(UserDetailsModel model) =>
      delete(UserDetailsTable.fromJson(model.toJson()));

  @override
  Future<bool> deleteUserByUUID(String uuid) async {
    return await storeBox.then((box) {
      Query<UserDetailsTable> query =
          box.query(UserDetailsTable_.uid.equals(uuid)).build();
      return query.findUnique();
    }).then((foundedUser) async {
      if (foundedUser != null) {
        return await delete(foundedUser);
      } else {
        return false;
      }
    }).onError((error, stackTrace) => throw FailureException(
          level: ExceptionLevel.ERROR,
          type: ExceptionType.NotFOUND,
          message: "Can't find user by uuid and delete :$uuid",
          error: error,
          stackTrace: stackTrace,
        ));
  }

  @override
  Future<List<UserDetailsModel?>> findAllUsers() async {
    List<UserDetailsModel?> foundedUsers = List.empty();
    for (var user in await findAll()) {
      if (user != null) {
        foundedUsers.add(UserModel.fromJson(user.toJson()));
      }
    }
    return foundedUsers;
  }

  @override
  Future<UserDetailsModel?> updateUser(UserDetailsModel entity) async {
    return await update(UserDetailsTable.fromJson(entity.toJson()))
        .then((isUpdated) async {
      if (isUpdated) {
        return await findUserByUUID(entity.uid ?? "");
      }
    }).onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.CantUPDATE,
              message: "Can't update user",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<UserDetailsModel?> updateUserByUUID(String uuid) async {
    return await findUserByUUID(uuid).then((foundedUser) async {
      return await update(UserDetailsTable.fromJson(foundedUser!.toJson()))
          .then((isUpdated) async {
        if (isUpdated) {
          return await findUserByUUID(uuid);
        }
      });
    }).onError((error, stackTrace) => throw FailureException(
          level: ExceptionLevel.ERROR,
          type: ExceptionType.CantUPDATE,
          message: "Can't update user",
          error: error,
          stackTrace: stackTrace,
        ));
  }

  @override
  Future<UserDetailsModel?> saveUser(UserDetailsModel user) async {
    return await save(user.toTable()).then((userId) async {
      if (userId != null) {
        return findById(userId).then((savedUser) {
          if (savedUser != null) {
            // auditor.audit(AuditType.create, model.toTable(), model.uid!);
            return UserDetailsModel.fromTable(savedUser);
          } else {
            return null;
          }
        });
      }
      return null;
    }).onError((error, stackTrace) => throw FailureException(
          level: ExceptionLevel.ERROR,
          type: ExceptionType.CantCREATE,
          message: "Can't save user.",
          error: error,
          stackTrace: stackTrace,
        ));
  }

// For api integration declare ds here
// like: final UserDetailsClient _client;
}
// part of zoncan.features.accounts.services;
//
// abstract class UserDetailsService extends Service<String, UserDetailsModel> {
//   Future<UserDetailsModel?> findByUUID(String uuid);
//   Future<UserDetailsModel?> findByEmail(String email);
//   Future<UserDetailsModel?> findByUsername(String username);
//   Future<bool> notExistsUser(String username);
// }
//
// class UserDetailsServiceImpl implements UserDetailsService {
//   final UserDetailsRepository userRepository;
//
//   UserDetailsServiceImpl(this.userRepository);
//
//   @override
//   Future<bool> delete(UserDetailsModel model) async {
//     final auditor = await Modular.get<AuthService>().auditor;
//     return userRepository.delete(model.toTable()).then((isDeleted) {
//       if (isDeleted) {
//         auditor.audit(AuditType.delete, model.toTable(), model.uid!);
//       }
//
//       return isDeleted;
//     }).onError((error, stackTrace) => throw FailureException(
//           level: ExceptionLevel.ERROR,
//           type: ExceptionType.CantDELETE,
//           message: "Can't delete user.",
//           error: error,
//           stackTrace: stackTrace,
//         ));
//   }
//
//   @override
//   Future<List<UserDetailsModel?>> findAll() {
//     return userRepository.findAll().then((users) {
//       List<UserDetailsModel?> usersModel = List.empty(growable: true);
//       if (users.isNotEmpty) {
//         for (var user in users) {
//           if (user != null) {
//             usersModel.add(UserDetailsModel.fromTable(user));
//           }
//         }
//       }
//       return usersModel;
//     }).onError((error, stackTrace) => throw FailureException(
//           type: ExceptionType.NotFOUND,
//           level: ExceptionLevel.ERROR,
//           message: "Can't load all users.",
//           error: error,
//           stackTrace: stackTrace,
//         ));
//   }
//
//   @override
//   Future<UserDetailsModel?> findById(String id) {
//     return userRepository.findById(int.parse(id)).then((foundedUser) {
//       if (foundedUser != null) {
//         return UserDetailsModel.fromTable(foundedUser);
//       }
//       return null;
//     }).onError((error, stackTrace) => throw FailureException(
//           level: ExceptionLevel.ERROR,
//           type: ExceptionType.NotFOUND,
//           message: "Can't find user by id: $id",
//           error: error,
//           stackTrace: stackTrace,
//         ));
//   }
//
//   @override
//   Future<UserDetailsModel?> save(UserDetailsModel model) async {
//     final auditor = await Modular.get<AuthService>().auditor;
//     return userRepository.save(model.toTable()).then((userId) async {
//       if (userId != null) {
//         return userRepository.findById(userId).then((savedUser) {
//           if (savedUser != null) {
//             auditor.audit(AuditType.create, model.toTable(), model.uid!);
//             return UserDetailsModel.fromTable(savedUser);
//           } else {
//             return null;
//           }
//         });
//       }
//       return null;
//     }).onError((error, stackTrace) => throw FailureException(
//           level: ExceptionLevel.ERROR,
//           type: ExceptionType.CantCREATE,
//           message: "Can't save user.",
//           error: error,
//           stackTrace: stackTrace,
//         ));
//   }
//
//   @override
//   Future<bool> update(UserDetailsModel model) {
//     return userRepository
//         .update(model.toTable())
//         .onError((error, stackTrace) => throw FailureException(
//               level: ExceptionLevel.ERROR,
//               type: ExceptionType.CantUPDATE,
//               message: "Can't update user: ${model.toJson()}",
//               error: error,
//               stackTrace: stackTrace,
//             ));
//   }
//
//   @override
//   Future<UserDetailsModel?> findByEmail(String email) {
//     return userRepository
//         .findByEmail(email)
//         .then((foundedUser) => foundedUser != null
//             ? UserDetailsModel.fromTable(foundedUser)
//             : null)
//         .onError((error, stackTrace) => throw FailureException(
//               level: ExceptionLevel.ERROR,
//               type: ExceptionType.NotFOUND,
//               message: "Can't find user by email:$email",
//               error: error,
//               stackTrace: stackTrace,
//             ));
//   }
//
//   @override
//   Future<UserDetailsModel?> findByUUID(String uuid) {
//     final matcher = RegExp(
//         r'/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/');
//     if (matcher.hasMatch(uuid)) {
//       return userRepository
//           .findByUUID(uuid)
//           .then((foundedUser) => foundedUser != null
//               ? UserDetailsModel.fromTable(foundedUser)
//               : null)
//           .onError((error, stackTrace) => throw FailureException(
//                 level: ExceptionLevel.ERROR,
//                 type: ExceptionType.NotFOUND,
//                 message: "Can't find user by uuid:$uuid",
//                 error: error,
//                 stackTrace: stackTrace,
//               ));
//     } else {
//       throw FailureException(
//           level: ExceptionLevel.WARNING,
//           type: ExceptionType.NotFOUND,
//           message: "UUID is not a valid.");
//     }
//   }
//
//   @override
//   Future<UserDetailsModel?> findByUsername(String username) {
//     return userRepository
//         .findByUsername(username)
//         .then((foundedUser) => foundedUser != null
//             ? UserDetailsModel.fromTable(foundedUser)
//             : null)
//         .onError((error, stackTrace) => throw FailureException(
//               level: ExceptionLevel.ERROR,
//               type: ExceptionType.NotFOUND,
//               message: "Can't find user by username:$username",
//               error: error,
//               stackTrace: stackTrace,
//             ));
//   }
//
//   @override
//   Future<bool> notExistsUser(String username) {
//     return userRepository.findByUsername(username).then((foundedUser) {
//       return foundedUser != null;
//     }).onError((error, stackTrace) => throw FailureException(
//           level: ExceptionLevel.ERROR,
//           type: ExceptionType.NotFOUND,
//           message: "Can't find user by username:$username, user is not exists",
//           error: error,
//           stackTrace: stackTrace,
//         ));
//   }
// }
