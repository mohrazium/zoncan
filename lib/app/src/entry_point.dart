part of zoncan.app;

class EntryPoint {
  final Widget app;
  EntryPoint.to()
      : app = ModularApp(
          debugMode: true,
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

  @override
  void initState() {
    super.initState();
    Fonts.instance.fontScale = appStateController.settings.fontScale;

    logger.setup();

    if (kDebugMode) {
      mainContext.config = mainContext.config.clone(
        isSpyEnabled: true,
      );
      mainContext.spy((e) => logger.info(e.toString()));
    }
    databaseSetup();
    Modular.setNavigatorKey(NavigatorHelper.maiNavigatorKey);

    Modular.setInitialRoute(Routing.to.splash.path);

    Modular.setObservers([
      NavigatorHelper.routeObserver,
      BotToastNavigatorObserver(),
    ]);

    botToastBuilder = BotToastInit();
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themizer.light,
        darkTheme: Themizer.dark,
        themeMode: appStateController.themeMode,
        navigatorKey: NavigatorHelper.wrapNavigatorKey,
        home: ReactionBuilder(
          builder: (reactionContext) {
            return autorun((_) async {
              try {
                LocaleSettings.setLocaleRaw(appStateController.settings.locale);
              } catch (ignore) {
                // Ignore
              }
              Fonts.instance.fontScale = appStateController.settings.fontScale;

              if (appStateController.isLoading) {
                LoadingScreen.instance.show(
                    context: reactionContext,
                    text: appStateController.loadingText);
              } else {
                LoadingScreen.instance.hide();
              }

              if (appStateController.errorHappened) {
                DialogHelper.showCrashReport(
                  reactionContext,
                  logger,
                  t.error,
                  appStateController.exception.toString(),
                );
              } else if (appStateController.exception != null &&
                  appStateController.exception!.justMessage) {
                await DialogHelper.showMessageBox(
                        context: reactionContext,
                        title: t.error,
                        dialogButtons: DialogButtons.OK,
                        message: appStateController.exception!.message!,
                        dialogType: DialogType.ERROR)
                    .then((value) {
                  appStateController.throwException(null);
                });
              }

              if (appStateController.shouldRefreshUI) {
                setState(() {});
              }
            });
          },
          child: Observer(builder: (obsContext) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: t.appName,
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
              useInheritedMediaQuery: true,
            );
          }),
        ));
  }
}
