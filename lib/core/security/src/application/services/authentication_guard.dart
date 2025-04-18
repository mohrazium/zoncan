part of '../../../security.dart';

abstract class _RedirectRoute {
  Future<Either<FailureException, bool?>> isUserAuthenticated();
  Future<Either<FailureException, bool?>> isUserExpired();
}

@Injectable()
class AuthenticationGuard implements _RedirectRoute {
  AuthenticationGuard();

  @override
  Future<Either<FailureException, bool?>> isUserAuthenticated() async {
    final authResult =
        await Injection.serviceLocator
            .get<AuthenticationRepository>()
            .isUserLoggedIn(); // Get the login status from AuthenticationRepository

    return authResult.fold(
      (failure) => const Right(
        false,
      ), // Return the failure as Left if authentication check fails
      (loggedIn) =>
          Right(loggedIn), // Return the logged-in status as Right if successful
    );
  }

  @override
  Future<Either<FailureException, bool?>> isUserExpired() async {
    final authResult =
        await Injection.serviceLocator
            .get<AuthenticationRepository>()
            .currentUserDetails(); // Get the login status from AuthenticationRepository

    return authResult.match(
      (failure) => const Right(
        false,
      ), // Return the failure as Left if authentication check fails
      (user) {
        final expirationDate = user.expirationDate;
        if (expirationDate == null) {
          return Right(false); // If no expiration date, it's not today.
        }

        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final expirationDay = DateTime(
          expirationDate.year,
          expirationDate.month,
          expirationDate.day,
        );
        return Right(expirationDay.isAtSameMomentAs(today));
      }, // Return the logged-in status as Right if successful
    );
  }
}
