part of zoncan.app;

class EntryPoint {
  final Widget app;
  EntryPoint.to()
      : app = ModularApp(
          module: App(),
          child: TranslationProvider(child: const Zoncan()),
        );
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

    Modular.to.addListener(() =>
        logger.info("Route changed to ${NavigatorHelper.currentRoute()}"));
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
