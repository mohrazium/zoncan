library zoncan.features.accounts;

import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/core.dart';

import 'presentation/presentation.dart';

export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';

class Accounts {
  static Accounts get get => Accounts();

  QRoute get routes => QRoute.withChild(
        path: Routing.to.accounts.path, // مسیر پدر
        name: Routing.to.accounts.named, // نام پدر
        builderChild: (router) => AccountsViewLarge(child: router), // پوسته
        // اگر کاربر لاگین است، به داشبورد هدایت شود
        middleware: [RedirectIfAuthenticatedMiddleware()],
        // مسیر پیش‌فرض داخل این پوسته (اولین فرمی که نمایش داده می‌شود)
        initRoute: Routing.to.login.path, // با مسیر کامل فرزند مشخص کنید
        children: [
          // فرزندان داخل پوسته Accounts
          QRoute(
            path: Routing.to.login.named, // فقط نام فرزند (نسبت به پدر)
            name: Routing.to.login.named, // نام منحصر به فرد برای QR.toName
            builder: () => const LoginForm(),
                        pageType: const QSlidePage(transitionDuration:kAnimationDuration),
          ),
          QRoute(
            path: Routing.to.signup.named,
            name: Routing.to.signup.named,
            builder: () => const SignupForm(),
            pageType: const QSlidePage(transitionDuration:kAnimationDuration),
          ),
          QRoute(
            path: Routing.to.passwordReset.named,
            name: Routing.to.passwordReset.named,
            builder: () => const PasswordRestForm(),
            pageType: const QSlidePage(transitionDuration:kAnimationDuration),
          ),
        ],
      );
}
