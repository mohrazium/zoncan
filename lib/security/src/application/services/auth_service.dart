import '../../data/repositories/user_details_repository.dart';
import '../../domain/models/user_details_model.dart';
import '../../encryption/encryption.dart' show Password;

abstract class AuthService {
  bool isUserLoggedIn();
  Future<UserDetailsModel> signUp(UserDetailsModel user, String password);
  Future<UserDetailsModel> login(String username, String password);
}

class AuthServiceImpl extends AuthService {
  final UserDetailsRepository _userRepository;

  AuthServiceImpl(this._userRepository);

  @override
  bool isUserLoggedIn() {
    return true;
  }

  @override
  Future<UserDetailsModel> signUp(
      UserDetailsModel user, String password) async {
    // final prepareUser =
    //     user.copyWith(encryptedPassword: Password.hash(password));
    // return _userRepository.createUser(prepareUser);
        throw UnimplementedError();

  }

  @override
  Future<UserDetailsModel> login(String username, String password) async {
    // TODO: implement login
    throw UnimplementedError();
  }
}
