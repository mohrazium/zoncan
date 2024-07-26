part of '../../../security.dart';

abstract class _RedirectRoute {
  Future<bool?> isUserAuthenticated();
  Future<bool?> isUserExpired();
}

@Injectable()
class AuthenticationGuard implements _RedirectRoute {
  AuthenticationGuard();

  @override
  Future<bool?> isUserAuthenticated() async {
    return await Injection.serviceLocator
        .get<AuthenticationRepository>()
        .isUserLoggedIn();
  }

  @override
  Future<bool?> isUserExpired() {
    // TODO: Check last login time with now if more than of some value for example 10 days, the user should expired and remove from cache and user should login again.
    
    return Future.value(false);
  }
}
