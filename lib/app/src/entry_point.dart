import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_interfaces/src/di/injector.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart' as sl;
import 'package:zoncan/localization/localization.dart';

import '../../auth/auth.dart';
import '../../features/login.dart';
import '../../features/home.dart';
import '../../features/splash.dart';
import 'routes.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class EntryPoint {
  final Widget app;
  EntryPoint.to()
      : app = ModularApp(
          module: AppModule(),
          child: TranslationProvider(child: const Zoncan()),
        );
}

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory<AuthService>((i) => AuthServiceImpl()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Routes.splash.path, module: SplashModule()),
        // RedirectRoute('/splash', to: '/'),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule(), guards: [AuthGuard()]),
        // WildcardRoute(child: (context, args) => const NotFoundPage()),
      ];
}

class NavigatorHelper {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static String getFirstRouteHistory() {
    List<ParallelRoute> history = Modular.to.navigateHistory;
    return history.first.name;
  }

  static String currentRoute() {
    List<ParallelRoute> history = Modular.to.navigateHistory;
    return history.last.name;
  }
}

class Zoncan extends StatefulWidget {
  const Zoncan({Key? key}) : super(key: key);

  @override
  State<Zoncan> createState() => _ZoncanState();
}

class _ZoncanState extends State<Zoncan> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute("/splash/");
    Modular.setObservers([routeObserver, BotToastNavigatorObserver()]);
    Modular.setNavigatorKey(NavigatorHelper.navigatorKey);
    final botToastBuilder = BotToastInit();

    return MaterialApp.router(
      title: "title",
      builder: (context, child) {
        return botToastBuilder(context, child);
      },
      locale: TranslationProvider.of(context).flutterLocale, // use provider
      supportedLocales: LocaleSettings.supportedLocales,
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        sl.SfGlobalLocalizations.delegate
      ],
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
