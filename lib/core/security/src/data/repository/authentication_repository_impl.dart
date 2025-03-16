part of '../../../security.dart';

const String _kSecretKey = "k53cr3tK3yPa55w0rd";

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final UserDetailsRepository _userDetailsRepository;
  final PasswordEncryption _passwordEncryption;
  final SecureStorageRepository _storage;
  final StorageProvider _storageProvider;

  final String _secretKey = "53cr3tK3y";
  final String _rememberMeUsrKey = "remember-usr";
  final String _rememberMePassKey = "remember-pass";

  AuthenticationRepositoryImpl(
    this._userDetailsRepository,
    this._storage,
    this._storageProvider,
  ) : _passwordEncryption = PasswordEncryption.initial(
          secretKey: _kSecretKey,
          difficulty: HashDifficulty.weak,
        ) {
    _storage.isData = true;
    _storage.initial(_secretKey);
  }

  @override
  Future<bool> isUserLoggedIn() async =>
      await currentUserDetails().then((user) => user != null);

  @override
  Future<UserDetailsModel?> signup(
      UserDetailsModel user, String password) async {
    if (user.email != null) {
      if (await emailAddressAlreadyExists(user.email!)) {
        throw FailureException(
            level: ExceptionLevel.WARNING,
            type: ExceptionType.IsDUPLICATED,
            message: "Already Exists Email");
      } else if (await usernameAlreadyExists(user.userName)) {
        throw FailureException(
            level: ExceptionLevel.WARNING,
            type: ExceptionType.IsDUPLICATED,
            message:"Already Exists Username");
      } else {
        return await _passwordEncryption.hashB64(password).then((hash) async {
          UserDetailsModel userDetails = user.copyWith(encryptedPassword: hash);
          return await _userDetailsRepository
              .saveUser(userDetails)
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
  Future<UserDetailsModel?> login(String username, String password,
      [bool rememberMe = false]) async {
    final currentUser = await currentUserDetails().then((inCacheUser) async {
      if (inCacheUser != null) {
        if (await _verifyPassword(inCacheUser.encryptedPassword!, password)) {
          return inCacheUser;
        }
      } else {
        if (isEmail(username)) {
          final foundedUser =
              await _userDetailsRepository.findUserByEmail(username);
          if (await _verifyPassword(
              foundedUser!.encryptedPassword!, password)) {
            _saveUserDetails(foundedUser);
            return foundedUser;
          }
        } else {
          final foundedUser =
              await _userDetailsRepository.findUserByUsername(username);
          if (await _verifyPassword(
              foundedUser!.encryptedPassword!, password)) {
            _saveUserDetails(foundedUser);
            return foundedUser;
          }
        }
      }
    }).onError((error, stackTrace) =>
        throw FailureException(error: error, stackTrace: stackTrace));
    if (currentUser != null && rememberMe) {
      _storageProvider.write(_rememberMeUsrKey, username);
      _storageProvider.write(_rememberMePassKey, password);
    } else {
      _storageProvider.delete(_rememberMeUsrKey);
      _storageProvider.delete(_rememberMePassKey);
    }
    return currentUser;
  }

  @override
  Future<UserDetailsModel?> currentUserDetails() => _storage
      .read(SecurityKeys.userDetails)
      .then((user) => user != null ? UserModel.fromJson(user) : null);

  Future<bool> _saveUserDetails(UserDetailsModel user) async =>
      _storage.write(SecurityKeys.userDetails, user.toJson());

  @override
  Future<bool> logout() {
    return _storage.delete(
      SecurityKeys.userDetails,
    );
  }

  @override
  Future<bool> emailAddressAlreadyExists(String email) async {
    await Future.delayed(kDelayWaiting);
    return await _userDetailsRepository
        .findUserByEmail(email)
        .then((e) => e != null);
  }

  @override
  Future<bool> usernameAlreadyExists(String username) async {
    await Future.delayed(kDelayWaiting);
    return await _userDetailsRepository
        .findUserByUsername(username)
        .then((e) => e != null);
  }

  Future<bool> _verifyPassword(
      String b64HashedPassword, String password) async {
    return await _passwordEncryption.verifyB64(password, b64HashedPassword)
        ? true
        : throw FailureException(
            level: ExceptionLevel.IGNORE, message: "Wrong Password!");
  }

  @override
  Future<String?> get rememberedPassword async =>
      await _storageProvider.read(_rememberMePassKey);

  @override
  Future<String?> get rememberedUsername async =>
      await _storageProvider.read(_rememberMeUsrKey);
}
