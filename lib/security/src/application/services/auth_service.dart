import '../../data/repositories/user_details_repository.dart';
import '../../domain/models/user_details_model.dart';

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
    //TODO: [ZON-10] AuthService : implement isUserLoggedIn
    return true;
  }

  @override
  Future<UserDetailsModel> signUp(
      UserDetailsModel user, String password) async {
    //TODO: [ZON-11] AuthService : implement signUp
    throw UnimplementedError();
  }

  @override
  Future<UserDetailsModel> login(String username, String password) async {
    //TODO: [ZON-12] AuthService : implement login
    throw UnimplementedError();
  }
}
