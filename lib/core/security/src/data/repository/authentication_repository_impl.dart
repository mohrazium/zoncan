part of '../../../security.dart';

// Secret key used for encryption, defined as a constant
const String _kSecretKey = "k53cr3tK3yPa55w0rd";

// Implementation of AuthenticationRepository marked as injectable
@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final UserDetailsRepository
      _userDetailsRepository; // Repository for user details operations
  final PasswordEncryption
      _passwordEncryption; // Service for encrypting and verifying passwords
  final SecureStorageRepository _storage; // Secure storage for sensitive data
  final StorageProvider
      _storageProvider; // General storage provider for key-value pairs

  final String _secretKey = "53cr3tK3y"; // Internal secret key for this class
  final String _rememberMeUsrKey =
      "remember-usr"; // Key for storing remembered username
  final String _rememberMePassKey =
      "remember-pass"; // Key for storing remembered password

  // Constructor with dependency injection and initialization of PasswordEncryption
  AuthenticationRepositoryImpl(
    this._userDetailsRepository,
    this._storage,
    this._storageProvider,
  ) : _passwordEncryption = PasswordEncryption.initial(
          secretKey: _kSecretKey,
          difficulty:
              HashDifficulty.weak, // Weak hash difficulty for faster processing
        ) {
    _storage.isData = true; // Indicate that storage contains data
    _storage.initial(_secretKey); // Initialize storage with the secret key
  }

  // Check if a user is currently logged in
  @override
  Future<Either<FailureException, bool>> isUserLoggedIn() async {
    try {
      final res = await currentUserDetails();
      return res.fold((failure) => Left(failure), (user) {
        if (user.isEmpty) {
          return const Right(false);
        } else {
          return const Right(true);
        }
      });
      // Returns true if user exists, failure otherwise
    } catch (e, s) {
      return Left(FailureException(
        type: ExceptionType.FAILED,
        level: LogLevel.ERROR,
        message: "Error retrieving logged in user from cache: $e",
        userMessage:
            "Error retrieving logged in user from memory", // User-friendly message
        error: e,
        stackTrace: s,
      ));
    }
  }

  // Retrieve the current user's details from secure storage
  @override
  Future<Either<FailureException, UserDetailsModel>>
      currentUserDetails() async {
    try {
      final user = await _storage
          .read(SecurityKeys.userDetails); // Read user data from secure storage
      if (user != null) {
        return Right(UserDetailsModelMapper.fromJson(
            user)); // Convert JSON to UserDetailsModel and return as success
      } else {
        return Right(UserDetailsModel.init());
      }
    } catch (e, stackTrace) {
      return Left(FailureException(
        type: ExceptionType.FAILED,
        level: LogLevel.ERROR,
        message: "Error retrieving user from cache: $e",
        userMessage:
            "Error retrieving user from memory", // User-friendly message
        error: e,
        stackTrace: stackTrace,
      ));
    }
  }

  // Check if an email address already exists in the system
  @override
  Future<Either<FailureException, bool>> emailAddressAlreadyExists(
      String email) async {
    await Future.delayed(kDelayWaiting); // Simulate network delay
    return await _userDetailsRepository
        .userExist(email); // True if email exists, failure if error occurs
  }

  // Handle user login with username/email and password
  @override
  Future<Either<FailureException, UserDetailsModel>> login(
      String username, String password,
      [bool rememberMe = false]) async {
    final cacheResult = await currentUserDetails(); // Check if user is in cache
    return cacheResult.fold(
      (failure) => Left(failure), // Return failure if cache retrieval fails
      (inCacheUser) async {
        // Case 1: User exists in cache
        if (!inCacheUser.isEmpty) {
          final verifyResult = await _verifyPassword(
              inCacheUser.encryptedPassword!,
              password); // Verify cached user's password
          return verifyResult.fold(
            (failure) =>
                Left(failure), // Return failure if password verification fails
            (isValid) => isValid
                ? Right(inCacheUser) // Return cached user if password matches
                : Left(FailureException(
                    type: ExceptionType.NotMATCH,
                    level: LogLevel.WARNING,
                    message: "Incorrect password for cached user",
                    userMessage: "Incorrect password", // User-friendly error
                  )),
          );
        } else {
          // Case 2: User not in cache, search by email or username
          final findResult = isEmail(username)
              ? await _userDetailsRepository.findUserByEmail(username)
              : await _userDetailsRepository.findUserByUsername(username);

          return findResult.fold(
            (failure) => Left(failure), // Return failure if user search fails
            (foundedUser) async {
              final verifyResult = await _verifyPassword(
                  foundedUser.encryptedPassword!,
                  password); // Verify found user's password
              return verifyResult.fold(
                (failure) =>
                    Left(failure), // Return failure if verification fails
                (isValid) async {
                  if (!isValid) {
                    return Left(FailureException(
                      type: ExceptionType.NotMATCH,
                      level: LogLevel.WARNING,
                      message: "Incorrect password for user: $username",
                      userMessage: "Incorrect password", // User-friendly error
                    ));
                  }

                  // Save user details to cache
                  final isSavedInCache = await _saveUserDetails(foundedUser);
                  if (!isSavedInCache) {
                    return Left(FailureException(
                      type: ExceptionType.FAILED,
                      level: LogLevel.ERROR,
                      message: "Failed to save user in cache",
                      userMessage:
                          "Error saving login details", // User-friendly error
                    ));
                  }

                  // Handle "Remember Me" functionality
                  if (rememberMe) {
                    try {
                      await _storageProvider.write(
                          _rememberMeUsrKey, username); // Save username
                      await _storageProvider.write(
                          _rememberMePassKey, password); // Save password
                    } catch (e, stackTrace) {
                      return Left(FailureException(
                        type: ExceptionType.FAILED,
                        level: LogLevel.ERROR,
                        message: "Error saving remember me data: $e",
                        userMessage:
                            "Error saving login details", // User-friendly error
                        error: e,
                        stackTrace: stackTrace,
                      ));
                    }
                  } else {
                    try {
                      await _storageProvider.delete(
                          _rememberMeUsrKey); // Delete remembered username
                      await _storageProvider.delete(
                          _rememberMePassKey); // Delete remembered password
                    } catch (e, stackTrace) {
                      FailureException(
                          error: e,
                          stackTrace: stackTrace,
                          message:
                              "Failed to delete remember me data: $e"); // Log error but don't fail login
                    }
                  }

                  return Right(foundedUser); // Return successful login result
                },
              );
            },
          );
        }
      },
    );
  }

  // Log out the current user by clearing cache
  @override
  Future<Either<FailureException, bool>> logout() async {
    try {
      return await _storage.delete(SecurityKeys.userDetails).then((res) => res
          ? Right(res) // Success if deletion worked
          : Left(FailureException(
              userMessage:
                  "User logout failed"))); // Failure if deletion didn't work
    } catch (e) {
      return Left(FailureException(
        type: ExceptionType.NotFOUND,
        level: LogLevel.WARNING,
        error: e,
      ));
    }
  }

  // Retrieve remembered password from storage
  @override
  Future<Either<FailureException, String>> get rememberedPassword async {
    try {
      return await _storageProvider.read(_rememberMePassKey).then((res) {
        if (res != null) {
          return Right(res); // Return password if found
        } else {
          return Left(FailureException(
              userMessage: "Password not found")); // Failure if not found
        }
      });
    } on Error catch (e) {
      return Left(FailureException(
        type: ExceptionType.NotFOUND,
        level: LogLevel.WARNING,
        error: e,
        stackTrace: e.stackTrace,
        userMessage: "Error retrieving password", // User-friendly error
      ));
    }
  }

  // Retrieve remembered username from storage
  @override
  Future<Either<FailureException, String>> get rememberedUsername async {
    try {
      return await _storageProvider.read(_rememberMeUsrKey).then((res) {
        if (res != null) {
          return Right(res); // Return username if found
        } else {
          return Left(FailureException(
              userMessage: "Username not found")); // Failure if not found
        }
      });
    } on Error catch (e) {
      return Left(FailureException(
        type: ExceptionType.NotFOUND,
        level: LogLevel.WARNING,
        error: e,
        stackTrace: e.stackTrace,
        userMessage: "Error retrieving username", // User-friendly error
      ));
    }
  }

  // Handle user signup with email, username, and password
  @override
  Future<Either<FailureException, UserDetailsModel>> signup(
      UserDetailsModel user, String password) async {
    // Check if email is provided by the user
    if (user.email == null) {
      return Left(FailureException(
        type: ExceptionType.NotVALID,
        level: LogLevel.WARNING,
        message: "Email is required for signup",
        userMessage: "Please enter an email", // User-friendly error
      ));
    }

    // Check for email duplication
    final emailCheck = await emailAddressAlreadyExists(user.email!);
    return emailCheck.fold(
      (failure) => Left(failure), // Return failure if email check fails
      (emailExists) async {
        if (emailExists) {
          return Left(FailureException(
            type: ExceptionType.IsDUPLICATED,
            level: LogLevel.WARNING,
            message: "Email already exists: ${user.email}",
            userMessage:
                "This email is already registered", // User-friendly error
          ));
        }

        // Check for username duplication
        final usernameCheck = await usernameAlreadyExists(user.userName);
        return usernameCheck.fold(
          (failure) => Left(failure), // Return failure if username check fails
          (usernameExists) async {
            if (usernameExists) {
              return Left(FailureException(
                type: ExceptionType.IsDUPLICATED,
                level: LogLevel.WARNING,
                message: "Username already exists: ${user.userName}",
                userMessage:
                    "This username is already taken", // User-friendly error
              ));
            }

            // Encrypt password and store user
            try {
              final hash = await _passwordEncryption
                  .hashB64(password); // Hash the password
              final userDetails = user.copyWith(
                  encryptedPassword: hash); // Update user with hashed password
              final savedUser = await _userDetailsRepository
                  .saveUser(userDetails); // Save user to repository

              return savedUser.fold(
                (failure) => Left(failure), // Return failure if saving fails
                (userModel) async {
                  final isUserInCache =
                      await _saveUserDetails(userModel); // Save to cache
                  if (isUserInCache) {
                    return Right(userModel); // Return success if cached
                  } else {
                    return Left(FailureException(
                      type: ExceptionType.FAILED,
                      level: LogLevel.ERROR,
                      message: "Failed to save user details in cache",
                      userMessage:
                          "Error saving user details", // User-friendly error
                    ));
                  }
                },
              );
            } catch (e, stackTrace) {
              return Left(FailureException(
                type: ExceptionType.FAILED,
                level: LogLevel.ERROR,
                message: "Error during signup: $e",
                userMessage:
                    "Error occurred during signup", // User-friendly error
                error: e,
                stackTrace: stackTrace,
              ));
            }
          },
        );
      },
    );
  }

  // Check if a username already exists in the system
  @override
  Future<Either<FailureException, bool>> usernameAlreadyExists(
      String username) async {
    await Future.delayed(kDelayWaiting); // Simulate network delay
    return await _userDetailsRepository
        .userExist(username); // True if username exists, failure if error
  }

  // Save user details to secure storage
  Future<bool> _saveUserDetails(UserDetailsModel user) async => _storage.write(
      SecurityKeys.userDetails,
      user.toJson()); // Write user JSON to storage and return success status

  // Verify a password against its hashed version
  Future<Either<FailureException, bool>> _verifyPassword(
      String b64HashedPassword, String password) async {
    try {
      return Right(await _passwordEncryption.verifyB64(
          password, b64HashedPassword)); // Verify password and return result
    } catch (e, stackTrace) {
      return Left(FailureException(
        type: ExceptionType.FAILED,
        level: LogLevel.ERROR,
        message: "Error verifying password: $e",
        userMessage: "Error verifying password", // User-friendly error
        error: e,
        stackTrace: stackTrace,
      ));
    }
  }
}
