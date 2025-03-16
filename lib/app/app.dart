library zoncan.app;

import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart' as sl;

import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/features/features.dart';

part 'src/application.dart';

part 'src/entry_point.dart';

part 'src/app_state_controller.dart';

part 'app.g.dart';

class App {
  static App get get => App();

  QRouteInformationParser get routeInformationParser =>
      const QRouteInformationParser();

  QRouterDelegate get routerDelegate => QRouterDelegate(
        _router,
        observers: [
          NavigatorHelper(),
          BotToastNavigatorObserver(),
        ],
      );

  List<QRoute> get _router => [
        QRoute(
          path: '/',
          builder: () {
            QR.navigator.replaceAll(Routing.to.splash.path);
            return Container();
          },
        ),
        Splash.get.routes,
        Accounts.get.routes,
        Home.get.routes,
      ];
}
