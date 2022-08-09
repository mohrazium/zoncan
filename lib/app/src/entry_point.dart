part of zoncan.app;

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

class Zoncan extends StatefulWidget {
  const Zoncan({Key? key}) : super(key: key);

  @override
  State<Zoncan> createState() => _ZoncanState();
}

class _ZoncanState extends State<Zoncan> {
  late final Function(BuildContext, Widget? child) botToastBuilder;

  Future<void> loadSettings() async {
    await Modular.get<SettingsProvider>().getLocalSettings().then((local) {
      LocaleSettings.setLocaleRaw(local);
    }).catchError((onError) {
      BotToast.showText(text: "Oops! $onError");
    });
  }

  @override
  void initState() {
    super.initState();
    Modular.setNavigatorKey(NavigatorHelper.navigatorKey);
    Modular.setInitialRoute(Routing.routes().splash.path);
    LoggerService.setup();

    Modular.setObservers([
      NavigatorHelper.routeObserver,
      BotToastNavigatorObserver(),
    ]);
    botToastBuilder = BotToastInit();
    loadSettings();
    Modular.to.addListener(() {
      final currentRoute = NavigatorHelper.currentRoute();
      logger.info("Route changed to $currentRoute");
    });
  }

  @override
  Widget build(BuildContext context) {
    var translator = Translations.of(context);
    return MaterialApp.router(
      title: translator.appName,
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
      themeMode: ThemeMode.light,
      theme: Themizer.light,
      darkTheme: Themizer.dark,
    );
  }
}
