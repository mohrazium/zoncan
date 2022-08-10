library zoncan.app;

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart' as sl;
import 'package:zoncan/common/common.dart';

import 'package:zoncan/config/config.dart'
    show Injector, LoggerService, Routing, logger;
import 'package:zoncan/constants/constants.dart';
import 'package:zoncan/features/accounts/accounts.dart';
import 'package:zoncan/features/features.dart' show Home, Splash;
import 'package:zoncan/localization/localization.dart'
    show LocaleSettings, TranslationProvider, Translations;
import 'package:zoncan/security/security.dart' show AuthGuard;
import 'package:zoncan/settings/settings.dart' show SettingsProvider;

part 'src/navigator_helper.dart';
part 'src/application.dart';
part 'src/entry_point.dart';

class App extends Module {
  @override
  List<Bind<Object>> get binds => [
        ...Injector.inject().appBinds,
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          Routing.routes().splash.path,
          transition: TransitionType.fadeIn,
          duration: kAnimationDuration,
          module: Splash(),
        ),
        ModuleRoute(
          Routing.routes().accounts.path,
          module: Accounts(),
          transition: TransitionType.fadeIn,
          duration: kAnimationDuration,
        ),
        ModuleRoute(
          Routing.routes().home.path,
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
