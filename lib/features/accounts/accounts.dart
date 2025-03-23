library zoncan.features.accounts;

import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/core/core.dart';

import 'package:zoncan/config/config.dart'
    show Injection, Routing, logger;
import 'presentation/presentation.dart';

export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';

class Accounts {
  static Accounts get get => Accounts();

  QRoute get routes => QRoute.withChild(
        path: Routing.to.accounts.path,
        builderChild: (accountForm) => AccountsPage(child: accountForm),
        initRoute: Routing.to.login.path,
        middleware: [
          QMiddlewareBuilder(
            redirectGuardFunc: (s) async {
              final guard = Injection.serviceLocator<AuthenticationGuard>();
              final authResult = await guard
                  .isUserAuthenticated(); // login status from AuthenticationGuard
              final isExpired = await guard
                  .isUserExpired(); // Check if user's session is expired

              return authResult.fold(
                (failure) {
                  logger.log(message:
                      "Authentication failed: ${failure.userMessage}"); // Log the failure
                  return  null; // Return null if authentication fails
                },
                (isAuthenticated) async {
                  if (!isAuthenticated!) {
                    return null; // Return null if user is not authenticated
                  }

                  return isExpired.fold(
                    (failure) {
                      print(
                          "usr expired: ${failure.userMessage}"); // Log the failure
                      return null; // Return null if authentication fails
                    },
                    (isExpired) async {
                      if (!isExpired!) {
                        return null; // Return null if user is not authenticated
                      }

                      return Routing.to.dashboard
                          .path; // Return dashboard path if authenticated and not expired
                    },
                  );
                },
              );
            },
          ),
        ],
        children: [
          QRoute(
              path: Routing.to.login.named,
              pageType: const QSlidePage(),
              builder: () => const LoginForm()),
          QRoute(
              path: Routing.to.signup.named,
              pageType: const QSlidePage(),
              builder: () => const SignupForm()),
          QRoute(
              path: Routing.to.passwordReset.named,
              pageType: const QSlidePage(),
              builder: () => const PasswordRestForm()),
        ],
      );
}
