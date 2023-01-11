library zoncan.features.accounts;

import 'package:flutter_modular/flutter_modular.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/constants/constants.dart';

/// Presentation
import 'screen/screen.dart';
export 'screen/screen.dart';
export 'data/data.dart';
export 'models/models.dart';
export 'services/services.dart';

class Accounts extends Module {
  @override
  List<Bind> get binds => Injector.inject.accountsBinds;

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            transition: TransitionType.fadeIn,
            duration: kAnimationDuration,
            child: (context, args) => const AccountsPage(),
            children: [
              ChildRoute(
                Routing.to.login.named,
                transition: TransitionType.fadeIn,
                duration: kAnimationDuration,
                child: (context, args) => const LoginForm(),
              ),
              ChildRoute(
                Routing.to.signup.named,
                transition: TransitionType.fadeIn,
                duration: kAnimationDuration,
                child: (context, args) => const SignupForm(),
              ),
              ChildRoute(
                Routing.to.passwordReset.named,
                transition: TransitionType.fadeIn,
                duration: kAnimationDuration,
                child: (context, args) => const PasswordRestForm(),
              ),
            ]),
      ];
}
