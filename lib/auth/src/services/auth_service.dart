import 'package:flutter_modular/flutter_modular.dart';

abstract class AuthService {
  bool isLoggedIn();
}

class AuthServiceImpl extends AuthService {
  @override
  bool isLoggedIn() {
    return true;
  }
}
