part of '../app.dart';

class EntryPoint {
  static EntryPoint get launch => EntryPoint._to();
  final Widget app;

  EntryPoint._to()
      : app = MaterialApp(
          home: TranslationProvider(child: const Zoncan()),
        );
}

class Zoncan extends StatefulWidget {
  const Zoncan({super.key});

  @override
  State<Zoncan> createState() => _ZoncanState();
}

class _ZoncanState extends State<Zoncan> {
  late final Function(BuildContext, Widget? child) botToastBuilder;
  final appStateController = Injection.serviceLocator.get<AppStateController>();

  Future<void> databaseSetup() async {
    final zoncanDatabaseHelper =
        Injection.serviceLocator<ZoncanDatabase>();
    try {
      logger.info("Zoncan Database was initialized!");
      zoncanDatabaseHelper.audit.setup();
    } catch (e) {
      logger.info("Zoncan Database can't initialize!+ $e");
    }
  }

  @override
  void initState() {
    super.initState();
    Fonts.instance.fontScale =
        appStateController.settings.fontScale ?? kDefaultFontScale;

    logger.setup();

    if (kDebugMode) {
      mainContext.config = mainContext.config.clone(
        isSpyEnabled: true,
      );
      mainContext.spy((e) => logger.info(e.toString()));
    }
    databaseSetup();
    botToastBuilder = BotToastInit();
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
    Injection.serviceLocator<ZoncanDatabase>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zoncanDatabaseHelper =
        Injection.serviceLocator<ZoncanDatabase>();
    zoncanDatabaseHelper.databaseFile.then((file) {
      logger.info("Path of Database : ${file.path}");
    });
    
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themizer.light,
        darkTheme: Themizer.dark,
        themeMode: appStateController.themeMode,
        navigatorKey: NavigatorHelper.accountsNavigatorKey,
        home: ReactionBuilder(
          builder: (reactionContext) {
            return autorun((_) async {
              try {
                LocaleSettings.setLocaleRaw(
                    appStateController.settings.locale ??
                        kDefaultLocale.countryCode!);
              } catch (ignore) {
                // Ignore
              }
              Fonts.instance.fontScale =
                  appStateController.settings.fontScale ?? kDefaultFontScale;

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
                  TranslationsProvider.translator.error,
                  appStateController.exception.toString(),
                );
              } else if (appStateController.exception != null &&
                  appStateController.exception!.justMessage) {
                await DialogHelper.showMessageBox(
                  context: reactionContext,
                  title: TranslationsProvider.translator.error,
                  dialogButtons: DialogButtons.OK,
                  message: appStateController.exception!.userMessage!,
                  dialogType: DialogType.ERROR,
                ).then((value) {
                  appStateController.showMessage(null);
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
              title: TranslationsProvider.translator.appName,
              builder: (materialBuilderContext, child) {
                return botToastBuilder(materialBuilderContext, child);
              },
              locale: TranslationsProvider.localeOf(context),
              supportedLocales: TranslationsProvider.supportedLocales,
              localizationsDelegates: const [
                ...GlobalMaterialLocalizations.delegates,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                sl.SfGlobalLocalizations.delegate
              ],
              themeMode: appStateController.themeMode,
              theme: Themizer.light,
              darkTheme: Themizer.dark,
              routeInformationParser: App.get.routeInformationParser,
              routerDelegate: App.get.routerDelegate,
            );
          }),
        ));
  }
}
