library zoncan.features.accounts;

import 'package:flutter_modular/flutter_modular.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/constants/constants.dart';

/// Presentation
import 'presentation/presentation.dart';
export 'presentation/presentation.dart';
export 'data/data.dart';
export 'domain/domain.dart';
export 'application/application.dart';

class Accounts extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            transition: TransitionType.fadeIn,
            duration: kAnimationDuration,
            child: (context, args) => const AccountsPage(),
            children: [
              ChildRoute(
                Routing.routes().login.named,
                transition: TransitionType.fadeIn,
                duration: kAnimationDuration,
                child: (context, args) => const LoginForm(),
              ),
              ChildRoute(Routing.routes().signup.named,
                  transition: TransitionType.fadeIn,
                  duration: kAnimationDuration,
                  child: (context, args) => const SignUpForm()),
              ChildRoute(
                Routing.routes().passwordReset.named,
                transition: TransitionType.fadeIn,
                duration: kAnimationDuration,
                child: (context, args) => const PasswordRestForm(),
              ),
            ]),
      ];
}
