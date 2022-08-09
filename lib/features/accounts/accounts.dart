library zoncan.features.login;

import 'dart:math';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:floy/floy.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:zoncan/common/common.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/constants/constants.dart';
import 'package:zoncan/localization/localization.dart';

/// Presentation
part 'presentation/pages/accounts_page.dart';
part 'presentation/views/accounts_view_large.dart';
part 'presentation/widgets/login_form.dart';
part 'presentation/widgets/signup_form.dart';
part 'presentation/widgets/password_reset_form.dart';
part 'presentation/widgets/login_header.dart';
part 'presentation/widgets/slider.dart';

///
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
