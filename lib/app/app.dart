library zoncan.app;

import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart' as sl;
import 'package:zoncan/common/common.dart';

import 'package:zoncan/config/config.dart'
    show Injector, Routing, logger;
import 'package:zoncan/constants/constants.dart';
import 'package:zoncan/exceptions/exceptions.dart';
import 'package:zoncan/features/accounts/accounts.dart';
import 'package:zoncan/features/features.dart' show Home, Splash;
import 'package:zoncan/localization/localization.dart'
    show LocaleSettings, TranslationProvider, t;
import 'package:zoncan/security/security.dart' show AuthGuard;
import 'package:zoncan/settings/settings.dart' show SettingProperties, SettingsProvider;

part 'src/navigator_helper.dart';
part 'src/application.dart';
part 'src/entry_point.dart';
part 'src/app_state_controller.dart';
part 'app.g.dart';

class App extends Module {
  @override
  List<Bind<Object>> get binds => [
        ...Injector.inject.appBinds,
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          Routing.to.splash.path,
          transition: TransitionType.fadeIn,
          duration: kAnimationDuration,
          module: Splash(),
        ),
        ModuleRoute(
          Routing.to.accounts.path,
          module: Accounts(),
          transition: TransitionType.fadeIn,
          duration: kAnimationDuration,
        ),
        ModuleRoute(
          Routing.to.home.path,
          module: Home(),
         guards: [AuthGuard()],
          transition: TransitionType.fadeIn,
          duration: kAnimationDuration,
        ),
        WildcardRoute(
          child: (context, args) => const NotFoundScreen(),
          transition: TransitionType.fadeIn,
          duration: kAnimationDuration,
        ),
      ];
}
