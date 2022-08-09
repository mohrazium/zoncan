import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:zoncan/config/config.dart' show Routing;

import 'auth_service.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: Routing.routes().accounts.path);
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    return Modular.get<AuthService>().isUserLoggedIn();
  }
}
