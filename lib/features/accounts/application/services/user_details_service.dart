part of zoncan.features.accounts.application;

abstract class UserDetailsService extends Service<String, UserDetailsModel> {
  Future<UserDetailsModel?> findByUUID(String uuid);
  Future<UserDetailsModel?> findByEmail(String email);
  Future<UserDetailsModel?> findByUsername(String username);
  Future<bool> notExistsUser(String username);
}

class UserDetailsServiceImpl implements UserDetailsService {
  final UserDetailsRepository userRepository;

  UserDetailsServiceImpl(this.userRepository);

  @override
  Future<bool> delete(UserDetailsModel model) async {
    return userRepository
        .delete(model.toTable())
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.CantDELETE,
              message: "Can't delete user.",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<List<UserDetailsModel?>> findAll() {
    return userRepository.findAll().then((users) {
      List<UserDetailsModel?> usersModel = List.empty(growable: true);
      if (users.isNotEmpty) {
        for (var user in users) {
          if (user != null) {
            usersModel.add(UserDetailsModel.fromTable(user));
          }
        }
      }
      return usersModel;
    }).onError((error, stackTrace) => throw FailureException(
          type: ExceptionType.NotFOUND,
          level: ExceptionLevel.ERROR,
          message: "Can't load all users.",
          error: error,
          stackTrace: stackTrace,
        ));
  }

  @override
  Future<UserDetailsModel?> findById(String id) {
    return userRepository.findById(int.parse(id)).then((foundedUser) {
      if (foundedUser != null) {
        return UserDetailsModel.fromTable(foundedUser);
      }
      return null;
    }).onError((error, stackTrace) => throw FailureException(
          level: ExceptionLevel.ERROR,
          type: ExceptionType.NotFOUND,
          message: "Can't find user by id: $id",
          error: error,
          stackTrace: stackTrace,
        ));
  }

  @override
  Future<UserDetailsModel?> save(UserDetailsModel model) {
    return userRepository.save(model.toTable()).then((userId) async {
      if (userId != null) {
        return userRepository.findById(userId).then((savedUser) =>
            savedUser != null ? UserDetailsModel.fromTable(savedUser) : null);
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

  @override
  Future<bool> update(UserDetailsModel model) {
    return userRepository
        .update(model.toTable())
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.CantUPDATE,
              message: "Can't update user: ${model.toJson()}",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<UserDetailsModel?> findByEmail(String email) {
    return userRepository
        .findByEmail(email)
        .then((foundedUser) => foundedUser != null
            ? UserDetailsModel.fromTable(foundedUser)
            : null)
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.NotFOUND,
              message: "Can't find user by email:$email",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<UserDetailsModel?> findByUUID(String uuid) {
    final matcher = RegExp(
        r'/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/');
    if (matcher.hasMatch(uuid)) {
      return userRepository
          .findByUUID(uuid)
          .then((foundedUser) => foundedUser != null
              ? UserDetailsModel.fromTable(foundedUser)
              : null)
          .onError((error, stackTrace) => throw FailureException(
                level: ExceptionLevel.ERROR,
                type: ExceptionType.NotFOUND,
                message: "Can't find user by uuid:$uuid",
                error: error,
                stackTrace: stackTrace,
              ));
    } else {
      throw FailureException(
          level: ExceptionLevel.WARNING,
          type: ExceptionType.NotFOUND,
          message: "UUID is not a valid.");
    }
  }

  @override
  Future<UserDetailsModel?> findByUsername(String username) {
    return userRepository
        .findByUsername(username)
        .then((foundedUser) => foundedUser != null
            ? UserDetailsModel.fromTable(foundedUser)
            : null)
        .onError((error, stackTrace) => throw FailureException(
              level: ExceptionLevel.ERROR,
              type: ExceptionType.NotFOUND,
              message: "Can't find user by username:$username",
              error: error,
              stackTrace: stackTrace,
            ));
  }

  @override
  Future<bool> notExistsUser(String username) {
    return userRepository.findByUsername(username).then((foundedUser) {
      return foundedUser != null;
    }).onError((error, stackTrace) => throw FailureException(
          level: ExceptionLevel.ERROR,
          type: ExceptionType.NotFOUND,
          message: "Can't find user by username:$username, user is not exists",
          error: error,
          stackTrace: stackTrace,
        ));
  }
}
