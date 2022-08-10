part of zoncan.features.accounts.application;

abstract class UserDetailsService extends Service<String, UserDetailsModel> {}

class UserDetailsServiceImpl implements UserDetailsService {
  final UserDetailsRepository userRepository;

  UserDetailsServiceImpl(this.userRepository);

  @override
  Future<bool> delete(UserDetailsModel model) async {
    return userRepository
        .delete(model.toTable())
        .onError((error, stackTrace) => throw FailureException(
              "Can't delete user.",
              error,
              stackTrace,
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
          "Can't load all users.",
          error,
          stackTrace,
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
          "Can't find user by id: $id",
          error,
          stackTrace,
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
          "Can't save user.",
          error,
          stackTrace,
        ));
  }

  @override
  Future<bool> update(UserDetailsModel model) {
    return userRepository
        .update(model.toTable())
        .onError((error, stackTrace) => throw FailureException(
              "Can't update user: ${model.toJson()}",
              error,
              stackTrace,
            ));
  }
}
