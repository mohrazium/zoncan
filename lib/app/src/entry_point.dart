import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart' as sl;

import 'package:zoncan/config/config.dart' show Injector, LoggerService;
import 'package:zoncan/features/features.dart'
    show SplashModule, LoginModule, HomeModule;
import 'package:zoncan/localization/localization.dart'
    show LocaleSettings, TranslationProvider;
import 'package:zoncan/security/security.dart' show AuthGuard;
import 'package:zoncan/settings/settings.dart' show SettingsProvider;

import 'navigator_helper.dart';
import 'routes.dart';

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
        ...Injector.inject().appModuleBinds,
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

class Zoncan extends StatefulWidget {
  const Zoncan({Key? key}) : super(key: key);

  @override
  State<Zoncan> createState() => _ZoncanState();
}

class _ZoncanState extends State<Zoncan> {
  Future<void> loadSettings() async {
    await Modular.get<SettingsProvider>().getLocalSettings().then((local) {
      LocaleSettings.setLocaleRaw(local);
    }).catchError((onError) {
      BotToast.showText(text: "Oops! $onError");
    });
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute("/splash/");
    Modular.setObservers(
        [NavigatorHelper.routeObserver, BotToastNavigatorObserver()]);
    Modular.setNavigatorKey(NavigatorHelper.navigatorKey);
    final botToastBuilder = BotToastInit();

    return MaterialApp.router(
      title: "title",
      builder: (context, child) {
        loadSettings();
        LoggerService.setup();
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
