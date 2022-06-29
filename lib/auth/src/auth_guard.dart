import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

import 'services/auth_service.dart';

class AuthGuard extends RouteGuard {
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    return Modular.get<AuthService>().isLoggedIn();
  }
}
