import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/src/constants/app_constants.dart';
import 'package:zoncan/config/src/router/routes.dart';
import 'package:zoncan/core/security/application/middewares/redirect_ifauth_middleware.dart';
import 'package:zoncan/features/accounts/presentation/forms/login_form.dart';
import 'package:zoncan/features/accounts/presentation/forms/signup_form.dart';
import 'package:zoncan/features/accounts/presentation/views/accounts_view.dart';
import 'package:zoncan/features/accounts/presentation/widgets/password_reset_form.dart';

class Accounts {
  static Accounts get get => Accounts();

  QRoute get routes => QRoute.withChild(
    path: Routing.to.accounts.path,
    name: Routing.to.accounts.named,
    builderChild: (router) => AccountsView(child: router),
    middleware: [RedirectIfAuthenticatedMiddleware()],
    initRoute: Routing.to.login.path,
    children: [
      QRoute(
        path: Routing.to.login.named,
        name: Routing.to.login.named,
        builder: () => const LoginForm(),
        pageType: const QSlidePage(transitionDuration: kAnimationDuration),
      ),
      QRoute(
        path: Routing.to.signup.named,
        name: Routing.to.signup.named,
        builder: () => const SignupForm(),
        pageType: const QSlidePage(transitionDuration: kAnimationDuration),
      ),
      QRoute(
        path: Routing.to.passwordReset.named,
        name: Routing.to.passwordReset.named,
        builder: () => const PasswordRestForm(),
        pageType: const QSlidePage(transitionDuration: kAnimationDuration),
      ),
    ],
  );
}
