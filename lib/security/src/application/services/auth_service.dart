part of zoncan.security;

const String _kSecretKey = "k53cr3tK3yPa55w0rd";

abstract class AuthService {
  bool isUserLoggedIn();
  Future<bool> usernameAlreadyExists(String username);
  Future<bool> emailAddressAlreadyExists(String email);
  Future<UserDetailsModel?> signup(UserDetailsModel user, String password);
  Future<UserDetailsModel?> login(String username, String password);
}

class AuthServiceImpl extends AuthService {
  final UserDetailsService _userDetailsService;
  final PasswordEncryption _passwordEncryption;
  final SecureStorage _storage;

  final String _secretKey = "53cr3tK3y";

  AuthServiceImpl(
    this._userDetailsService,
    this._storage,
  ) : _passwordEncryption = PasswordEncryption.initial(
          secretKey: _kSecretKey,
          difficulty: HashDifficulty.weak,
        ) {
    _storage.isData = true;
    _storage.initial(_secretKey);
  }

  @override
  bool isUserLoggedIn() {
    //TODO: [ZON-10] AuthService : implement isUserLoggedIn
    return false;
  }

  @override
  Future<UserDetailsModel?> signup(
      UserDetailsModel user, String password) async {
    if (user.email != null) {
      if (await emailAddressAlreadyExists(user.email!)) {
        throw FailureException(
            level: ExceptionLevel.WARNING,
            type: ExceptionType.IsDUPLICATED,
            message: t.validation.alreadyExistsEmail);
      } else if (await usernameAlreadyExists(user.userName)) {
        throw FailureException(
            level: ExceptionLevel.WARNING,
            type: ExceptionType.IsDUPLICATED,
            message: t.validation.alreadyExistsUsername);
      } else {
        return await _passwordEncryption.hashB64(password).then((hash) async {
          UserDetailsModel userDetails =
              user.rebuild((u) async => u..encryptedPassword = hash);
          return await _userDetailsService
              .save(userDetails)
              .then((savedUser) async {
            if (savedUser != null) {
              return await _saveUserDetails(savedUser).then((isUserInCache) {
                if (isUserInCache) {
                  return savedUser;
                }
              }).onError((error, stackTrace) => throw FailureException(
                  message: "Can't save user details in cache.",
                  error: error,
                  stackTrace: stackTrace));
            } else {
              throw FailureException(message: "User details was not saved");
            }
          }).onError((error, stackTrace) =>
                  throw FailureException(error: error, stackTrace: stackTrace));
        });
      }
    } else {
      throw FailureException(
          message: "Please provide an email address for signup");
    }
  }

  @override
  Future<UserDetailsModel?> login(String username, String password) async {
    //TODO: [ZON-12] AuthService : implement login
    throw UnimplementedError();
  }

  Future<bool> _saveUserDetails(UserDetailsModel user) async {
    return _storage.write(user.toJson());
  }

  Future<UserDetailsModel> _getUserDetails() {
    return _storage.read().then((u) => UserDetailsModel.fromJson(u));
  }

  Future<bool> _deleteUserDetails() {
    return _storage.delete();
  }

  @override
  Future<bool> emailAddressAlreadyExists(String email) async {
    await Future.delayed(kDelayWaiting);
    return await _userDetailsService
        .findByEmail(email)
        .then((e) => e != null)
        .onError((error, stackTrace) =>
            throw FailureException(error: error, stackTrace: stackTrace));
  }

  @override
  Future<bool> usernameAlreadyExists(String username) async {
    await Future.delayed(kDelayWaiting);
    return await _userDetailsService
        .findByUsername(username)
        .then((e) => e != null)
        .onError((error, stackTrace) =>
            throw FailureException(error: error, stackTrace: stackTrace));
  }
}
