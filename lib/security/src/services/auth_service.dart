abstract class AuthService {
  bool isLoggedIn();
}

class AuthServiceImpl extends AuthService {
  @override
  bool isLoggedIn() {
    return true;
  }
}
