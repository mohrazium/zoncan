library zoncan.features.accounts;

import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/core/core.dart';

import 'package:zoncan/config/config.dart'
    show Injection, NavigatorHelper, Routing;
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
              final bool? isAuth = await guard.isUserAuthenticated();
              final bool? isExpired = await guard.isUserExpired();
              if (isAuth!) {
                if (isExpired!) {
                  return null;
                } else {
                  return Routing.to.dashboard.path;
                }
              } else {
                return null;
              }
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
