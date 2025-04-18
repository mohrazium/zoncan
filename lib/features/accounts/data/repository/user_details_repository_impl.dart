part of '../data.dart';

@Injectable(as: UserDetailsRepository)
class UserDetailsRepositoryImpl implements UserDetailsRepository {
  final UserDetailsDao _userDetailsDao;
  UserDetailsRepositoryImpl(this._userDetailsDao);

  @override
  Future<Either<FailureException, UserDetailsModel>> saveUser(
    UserDetailsModel user,
  ) async {
    try {
      if (user.uid == null) {
        user = user.copyWith(uid: const Uuid().v4());
      }

      if (user.userName.isEmpty) {
        user = user.copyWith(userName: user.email);
      }

      UserDetailsModel? savedUser = await _userDetailsDao
          .insert(user.toEntity().toData())
          .then(
            (savedUser) => UserDetailsModel.fromEntity(savedUser!.toEntity()),
          );
      if (savedUser != null) {
        return Right(savedUser);
      } else {
        return Left(FailureException(userMessage: "کاربر ذخیره نشد"));
      }
    } on Error catch (e) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantCREATE,
          message: "Can't save this user :${user.toString()}",
          userMessage: ".کاربر ذخیره نشد! مشکلی در ذخیره کاربر پیش امده است",
          error: e,
          stackTrace: e.stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, List<UserDetailsModel>>>
  findAllUsers() async {
    try {
      List<UserDetailsModel> users = List.empty();
      await _userDetailsDao.getAllUser.then((res) {
        for (final user in res) {
          if (user != null) {
            users.add(UserDetailsModel.fromEntity(user.toEntity()));
          }
        }
      });
      return Right(users);
    } catch (e, stackTrace) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantDELETE,
          error: e,
          stackTrace: stackTrace,
          message: "Can't retrive users from db",
          userMessage: "بارگذاری کاربران امکان پذیرنیست",
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, UserDetailsModel>> findUserByEmail(
    String email,
  ) async {
    try {
      final foundedUser = await _userDetailsDao.getUserByEmail(email);
      if (foundedUser == null) {
        return Left(
          FailureException(
            level: LogLevel.ERROR,
            type: ExceptionType.CantCREATE,
            message:
                "Can't find this user by username or email address :$email",
            userMessage: "کاربری بااین ایمیل یافت نشد!",
          ),
        );
      } else {
        return Right(UserDetailsModel.fromEntity(foundedUser.toEntity()));
      }
    } on Error catch (e) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantCREATE,
          message: "Finding user by :$email faild. check the error",
          userMessage:
              ".کاربر یافت نشد! مشکلی درعملیات یافتن کاربر پیش امده است",
          error: e,
          stackTrace: e.stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, UserDetailsModel>> findUser(
    String uuid,
  ) async {
    try {
      final user = await _userDetailsDao.getUser(uuid);
      if (user != null) {
        return Right(UserDetailsModel.fromEntity(user.toEntity()));
      } else {
        return Left(
          FailureException(
            level: LogLevel.INFO,
            type: ExceptionType.NONE,
            userMessage: "متاسفانه کاربر یافت نشد",
          ),
        );
      }
    } catch (e, stackTrace) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantDELETE,
          error: e,
          stackTrace: stackTrace,
          message: "Can't find this user by uid:$uuid",
          userMessage: "خطا در پیدا کردن کاربر!",
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, UserDetailsModel>> findUserByUsername(
    String username,
  ) async {
    try {
      final user = await _userDetailsDao.getUserByUsername(username);
      if (user != null) {
        return Right(UserDetailsModel.fromEntity(user.toEntity()));
      } else {
        return Left(
          FailureException(
            level: LogLevel.INFO,
            type: ExceptionType.NONE,
            userMessage: "کاربری بااین نام کاربری یافت نشد!",
          ),
        );
      }
    } on Error catch (e) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantCREATE,
          message: "Finding user by :$username faild. check the error",
          userMessage:
              ".کاربر یافت نشد! مشکلی درعملیات یافتن کاربر پیش امده است",
          error: e,
          stackTrace: e.stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, UserDetailsModel>> updateUser(
    UserDetailsModel model,
  ) async {
    try {
      final user = await _userDetailsDao.updateUser(model.toEntity().toData());
      if (user != null) {
        return Right(UserDetailsModel.fromEntity(user.toEntity()));
      } else {
        return Left(
          FailureException(
            level: LogLevel.INFO,
            type: ExceptionType.NONE,
            userMessage: "اطلاعات کاربر بروز نشد",
          ),
        );
      }
    } on Error catch (e) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantCREATE,
          message:
              "Updating user by :${model.toString()} faild. check the error",
          userMessage:
              ".کاربر یافت نشد! مشکلی درعملیات بروزرسانی کاربر پیش امده است",
          error: e,
          stackTrace: e.stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, bool>> userExist(
    String usernameOrEmail,
  ) async {
    try {
      final userByEmail = await _userDetailsDao.getUserByEmail(usernameOrEmail);
      final userByUsername = await _userDetailsDao.getUserByUsername(
        usernameOrEmail,
      );
      if (userByEmail != null || userByUsername != null) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on Error catch (e) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.NotFOUND,
          message: "Finding user by :$usernameOrEmail faild. check the error",
          userMessage:
              ".کاربر یافت نشد! مشکلی درعملیات جستجوی کاربر پیش امده است",
          error: e,
          stackTrace: e.stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, bool>> removeUser(
    UserDetailsModel entity,
  ) async {
    try {
      return await _userDetailsDao
          .deleteUser(entity.toEntity().toData())
          .then((res) => Right(res));
    } catch (e, stackTrace) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantDELETE,
          error: e,
          stackTrace: stackTrace,
          message: "Can't find this user by uid:${entity.uid}",
          userMessage: "خطا در حذف کاربر!",
        ),
      );
    }
  }
}

// For api integration declare ds here
// like: final UserDetailsClient _client;
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

///! person repo
///
///part of '../data.dart';

//@Injectable(as: PersonRepository)
//class PersonRepositoryImpl implements PersonRepository {
// @override
// Future<Box<PersonTable>> get storeBox async {
//   ZoncanDatabase database = Injection.serviceLocator.get<ZoncanDatabase>();
//   return await database
//       .zoncanObjectBoxDB
//       .then((db) => db.objectBoxStore.box<PersonTable>())
//       .onError((error, stackTrace) =>
//   throw FailureException(
//     level: ExceptionLevel.ERROR,
//     type: ExceptionType.CantCREATE,
//     message:
//     "Can't create user details box in user details repository.",
//     error: error,
//     stackTrace: stackTrace,
//   ));
// }

// @override
// Future<bool> delete(PersonTable table) async {
//   return await storeBox
//       .then((box) {
//     if (table.id != 0) {
//       if (box.get(table.id) != null) {
//         return box;
//       } else {
//         throw FailureException(
//           level: ExceptionLevel.ERROR,
//           type: ExceptionType.NotFOUND,
//           message: "User not found by id : ${table.id}",
//         );
//       }
//     } else {
//       throw FailureException(
//         level: ExceptionLevel.ERROR,
//         type: ExceptionType.NotVALID,
//         message: "Not valid user details.",
//       );
//     }
//   })
//       .then((validBox) => validBox.remove(table.id))
//       .onError((error, stackTrace) =>
//   throw FailureException(
//     level: ExceptionLevel.ERROR,
//     type: ExceptionType.CantDELETE,
//     message: "Can't delete user.",
//     error: error,
//     stackTrace: stackTrace,
//   ));
// }

// @override
// Future<int> deleteAll() async {
//   return await storeBox
//       .then((box) => box.removeAll())
//       .onError((error, stackTrace) =>
//   throw FailureException(
//     level: ExceptionLevel.ERROR,
//     type: ExceptionType.CantDELETE,
//     message: "Can't delete all users.",
//     error: error,
//     stackTrace: stackTrace,
//   ));
// }

// @override
// Future<List<PersonTable?>> findAll() async {
//   return await storeBox
//       .then((box) => box.getAll())
//       .onError((error, stackTrace) =>
//   throw FailureException(
//     level: ExceptionLevel.ERROR,
//     type: ExceptionType.NotFOUND,
//     message: "Can't find all users.",
//     error: error,
//     stackTrace: stackTrace,
//   ));
// }

// @override
// Future<PersonTable?> findById(int id) async {
//   return await storeBox
//       .then((box) => box.get(id))
//       .onError((error, stackTrace) =>
//   throw FailureException(
//     level: ExceptionLevel.ERROR,
//     type: ExceptionType.NotFOUND,
//     message: "Can't find user by id $id",
//     error: error,
//     stackTrace: stackTrace,
//   ));
// }

// @override
// Future<List<PersonTable?>> findByIds(List<int> ids) async {
//   return await storeBox
//       .then((box) => box.getMany(ids))
//       .onError((error, stackTrace) =>
//   throw FailureException(
//     level: ExceptionLevel.ERROR,
//     type: ExceptionType.NotFOUND,
//     message: "Can't find users by this id's $ids",
//     error: error,
//     stackTrace: stackTrace,
//   ));
// }

// @override
// Future<int?> save(PersonTable table) async {
//   return await storeBox
//       .then((box) async => await box.putAsync(table, mode: PutMode.insert))
//       .onError((error, stackTrace) =>
//   throw FailureException(
//     level: ExceptionLevel.ERROR,
//     type: ExceptionType.CantCREATE,
//     message: "Can't save this user :${table.toString()}",
//     error: error,
//     stackTrace: stackTrace,
//   ));
// }

// @override
// Future<List<int>> saveAll(List<PersonTable> tables) async {
//   return await storeBox
//       .then((box) async => box.putMany(tables, mode: PutMode.insert))
//       .onError((error, stackTrace) =>
//   throw FailureException(
//     level: ExceptionLevel.ERROR,
//     type: ExceptionType.CantCREATE,
//     message: "Can't save all users :${tables.toString()}",
//     error: error,
//     stackTrace: stackTrace,
//   ));
// }

// @override
// Future<int> saveQueued(PersonTable table) async {
//   return await storeBox
//       .then((box) async => box.putQueued(table, mode: PutMode.insert))
//       .onError((error, stackTrace) =>
//   throw FailureException(
//     level: ExceptionLevel.ERROR,
//     type: ExceptionType.CantCREATE,
//     message: "Can't save user in queue :${table.toString()}",
//     error: error,
//     stackTrace: stackTrace,
//   ));
// }

// @override
// Future<bool> update(PersonTable table) async {
//   return await storeBox
//       .then((box) async => await box.putAsync(table, mode: PutMode.update))
//       .then((updatedUserId) async {
//     return updatedUserId == table.id
//         ? true
//         : throw FailureException(
//       level: ExceptionLevel.ERROR,
//       type: ExceptionType.CantUPDATE,
//       message: "Can't update this user :${table.toString()}",
//     );
//   }).onError((error, stackTrace) =>
//   throw FailureException(
//     level: ExceptionLevel.ERROR,
//     type: ExceptionType.CantUPDATE,
//     message: "Can't update user in queue :${table.toString()}",
//     error: error,
//     stackTrace: stackTrace,
//   ));
// }
//
//   @override
//   Future<UserDetailsModel?> findUserByEmail(String email) async {
//     return _userDetailsRepository.findUserByEmail(email);
//     // return await storeBox
//     //     .then((box) {
//     //       Query<PersonTable> query =
//     //           box.query(PersonTable_.email.equals(email)).build();
//     //       return query.findUnique();
//     //     })
//     //     .then((foundedUser) => foundedUser != null
//     //         ? UserDetailsModel.fromTable(UserDetailsTable.fromJson(foundedUser.toJson()))
//     //         : null)
//     //     .onError((error, stackTrace) => throw FailureException(
//     //           level: ExceptionLevel.ERROR,
//     //           type: ExceptionType.NotFOUND,
//     //           message: "Can't find user by email :$email",
//     //           error: error,
//     //           stackTrace: stackTrace,
//     //         ));
//   }
//
//   @override
//   Future<UserDetailsModel?> findUserByUUID(String uuid) async {
//     return _userDetailsRepository.findUserByUUID(uuid);
//     // return await storeBox
//     //     .then((box) {
//     //       Query<PersonTable> query =
//     //           box.query(UserDetailsTable_.uid.equals(uuid)).build();
//     //       return query.findUnique();
//     //     })
//     //     .then((foundedUser) => foundedUser != null
//     //         ? UserModel.fromJson(foundedUser.toJson())
//     //         : null)
//     //     .onError((error, stackTrace) => throw FailureException(
//     //           level: ExceptionLevel.ERROR,
//     //           type: ExceptionType.NotFOUND,
//     //           message: "Can't find user by uuid :$uuid",
//     //           error: error,
//     //           stackTrace: stackTrace,
//     //         ));
//   }
//
//   @override
//   Future<UserDetailsModel?> findUserByUsername(String username) async {
//     return _userDetailsRepository.findUserByUsername(username);
//     // return await storeBox
//     //     .then((box) {
//     //       Query<PersonTable> query =
//     //           box.query(UserDetailsTable_.userName.equals(username)).build();
//     //       return query.findUnique();
//     //     })
//     //     .then((foundedUser) => foundedUser != null
//     //         ? UserDetailsModel.fromJson(foundedUser.toJson())
//     //         : null)
//     //     .onError((error, stackTrace) => throw FailureException(
//     //           level: ExceptionLevel.ERROR,
//     //           type: ExceptionType.NotFOUND,
//     //           message: "Can't find user by username :$username",
//     //           error: error,
//     //           stackTrace: stackTrace,
//     //         ));
//   }
//
//   @override
//   Future<bool> deleteUser(UserDetailsModel model) =>
//       _userDetailsRepository.deleteUser(model);
//
//   // delete(PersonTable.fromJson(model.toJson()));
//
//   @override
//   Future<bool> deleteUserByUUID(String uuid) async {
//     return _userDetailsRepository.deleteUserByUUID(uuid);
//     // return await storeBox.then((box) {
//     //   Query<PersonTable> query =
//     //       box.query(PersonTable_.uid.equals(uuid)).build();
//     //   return query.findUnique();
//     // }).then((foundedUser) async {
//     //   if (foundedUser != null) {
//     //     return await delete(foundedUser);
//     //   } else {
//     //     return false;
//     //   }
//     // }).onError((error, stackTrace) => throw FailureException(
//     //       level: ExceptionLevel.ERROR,
//     //       type: ExceptionType.NotFOUND,
//     //       message: "Can't find user by uuid and delete :$uuid",
//     //       error: error,
//     //       stackTrace: stackTrace,
//     //     ));
//   }
//
//   @override
//   Future<List<UserDetailsModel?>> findAllUsers() async {
//     return _userDetailsRepository.findAllUsers();
//     // List<UserDetailsModel?> foundedUsers = List.empty();
//     // for (var user in await findAll()) {
//     //   if (user != null) {
//     //     foundedUsers.add(UserDetailsModel.fromTable(user));
//     //   }
//     // }
//     // return foundedUsers;
//   }
//
//   @override
//   Future<UserDetailsModel?> updateUser(UserDetailsModel entity) async {
//     return _userDetailsRepository.updateUser(entity);
//     // return await update(PersonTable.fromJson(entity.toJson()))
//     //     .then((isUpdated) async {
//     //   if (isUpdated) {
//     //     return await findUserByUUID(entity.uid ?? "");
//     //   }
//     // }).onError((error, stackTrace) => throw FailureException(
//     //           level: ExceptionLevel.ERROR,
//     //           type: ExceptionType.CantUPDATE,
//     //           message: "Can't update user",
//     //           error: error,
//     //           stackTrace: stackTrace,
//     //         ));
//   }
//
//   @override
//   Future<UserDetailsModel?> updateUserByUUID(String uuid) async {
//     return _userDetailsRepository.updateUserByUUID(uuid);
//     // return await findUserByUUID(uuid).then((foundedUser) async {
//     //   return await update(foundedUser!.toTable().person!)
//     //       .then((isUpdated) async {
//     //     if (isUpdated) {
//     //       return await findUserByUUID(uuid);
//     //     }
//     //   });
//     // }).onError((error, stackTrace) => throw FailureException(
//     //       level: ExceptionLevel.ERROR,
//     //       type: ExceptionType.CantUPDATE,
//     //       message: "Can't update user",
//     //       error: error,
//     //       stackTrace: stackTrace,
//     //     ));
//   }
//
//   @override
//   Future<UserDetailsModel?> saveUser(UserDetailsModel user) async {
//     return _userDetailsRepository.saveUser(user);
//     // return await save(user.toTable().person!).then((userId) async {
//     //   if (userId != null) {
//     //     return findById(userId).then((savedUser) {
//     //       if (savedUser != null) {
//     //         // auditor.audit(AuditType.create, model.toTable(), model.uid!);
//     //         return UserDetailsModel.fromTable(savedUser.userDetails);
//     //       } else {
//     //         return null;
//     //       }
//     //     });
//     //   }
//     //   return null;
//     // }).onError((error, stackTrace) => throw FailureException(
//     //       level: ExceptionLevel.ERROR,
//     //       type: ExceptionType.CantCREATE,
//     //       message: "Can't save user.",
//     //       error: error,
//     //       stackTrace: stackTrace,
//     //     ));
//   }
// }
// For api integration declare ds here
// like: final UserDetailsClient _client;
//}
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

///
///
