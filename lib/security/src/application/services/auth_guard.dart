part of zoncan.security;

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: Routing.to.login.path);
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    return Modular.get<AuthService>().isUserLoggedIn();
  }
}
