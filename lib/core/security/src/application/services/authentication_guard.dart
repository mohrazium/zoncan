part of '../../../security.dart';

abstract class _RedirectRoute {
  Future<Either<FailureException,bool?>> isUserAuthenticated();
  Future<Either<FailureException,bool?>> isUserExpired();
}

@Injectable()
class AuthenticationGuard implements _RedirectRoute {
  AuthenticationGuard();

@override
Future<Either<FailureException, bool?>> isUserAuthenticated() async {
  final authResult = await Injection.serviceLocator
      .get<AuthenticationRepository>()
      .isUserLoggedIn(); // Get the login status from AuthenticationRepository
  
  return authResult.fold(
    (failure) => const Right(false), // Return the failure as Left if authentication check fails
    (loggedIn) => Right(loggedIn), // Return the logged-in status as Right if successful
  );
}
  @override
Future<Either<FailureException, bool?>> isUserExpired() async {
  final authResult = await Injection.serviceLocator
      .get<AuthenticationRepository>()
      .isUserLoggedIn(); // Get the login status from AuthenticationRepository
  
  return authResult.fold(
    (failure) => const Right(false), // Return the failure as Left if authentication check fails
    (loggedIn) => Right(loggedIn), // Return the logged-in status as Right if successful
  );
}
}
