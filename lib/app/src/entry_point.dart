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
  final appStateController = Modular.get<AppStateController>();

  Future<void> databaseSetup() async {
    final db = await Modular.getAsync<ZoncanDatabase>();
    logger.info(" db into ${db.store.directoryPath}");
  }

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
    logger.setup();

    if (kDebugMode) {
      mainContext.config = mainContext.config.clone(
        isSpyEnabled: true,
      );
      mainContext.spy((e) => logger.info(e.toString()));
    }
    databaseSetup();
    Modular.setNavigatorKey(NavigatorHelper.maiNavigatorKey);

    Modular.setInitialRoute(Routing.routes().splash.path);

    Modular.setObservers([
      NavigatorHelper.routeObserver,
      BotToastNavigatorObserver(),
    ]);

    botToastBuilder = BotToastInit();

    loadSettings();

    Modular.to.addListener(() =>
        logger.info("Route changed to ${NavigatorHelper.currentRoute()}"));

    appStateController.initState();
  }

  @override
  void didChangeDependencies() {
    appStateController.didChangeDependencies();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    appStateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var translator = Translations.of(context);

    return MaterialApp(
        theme: Themizer.light,
        darkTheme: Themizer.dark,
        themeMode: appStateController.themeMode,
        navigatorKey: NavigatorHelper.wrapNavigatorKey,
        home: ReactionBuilder(
          builder: (reactionContext) {
            return autorun((_) {
              if (appStateController.isLoading) {
                LoadingScreen.instance.show(
                    context: reactionContext, text: appStateController.loadingText);
              } else {
                LoadingScreen.instance.hide();
              }

              if (appStateController.errorHappened) {
                if (appStateController.exception!.justMessage) {
                  DialogHelper.showMessageBox(
                      context: reactionContext,
                      title: "خطا",
                      dialogButtons: DialogButtons.OK,
                      message: appStateController.exception!.message!,
                      dialogType: DialogType.ERROR);
                } else {
                  DialogHelper.showCrashReport(
                    reactionContext,
                    logger,
                    "خطا",
                    appStateController.exception.toString(),
                  );
                }
                appStateController.throwException(null);
              }
            });
          },
          child: Observer(builder: (obsContext) {
            return MaterialApp.router(
              title: translator.appName,
              builder: (materialBuilderContext, child) {
                return botToastBuilder(materialBuilderContext, child);
              },
              locale: TranslationProvider.of(context).flutterLocale,
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
              themeMode: appStateController.themeMode,
              theme: Themizer.light,
              darkTheme: Themizer.dark,
            );
          }),
        ));
  }
}
