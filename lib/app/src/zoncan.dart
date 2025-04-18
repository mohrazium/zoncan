part of '../app.dart';

class Zoncan extends Hooks.HookWidget {
  const Zoncan({super.key});

  @override
  Widget build(BuildContext context) {
    final appInstanse = Hooks.useMemoized(() => Application.instance);
    final appStateController = Hooks.useMemoized(
      () => Injection.serviceLocator.get<AppStateController>(),
    );
    final zoncanDatabaseHelper = Hooks.useMemoized(
      () => Injection.serviceLocator<ZoncanDatabase>(),
    );

    Hooks.useEffect(() {
      logger.setup();

      // if (kDebugMode) {
      //   mainContext.config = mainContext.config.clone(isSpyEnabled: true);
      //   mainContext.spy(
      //     (e) => ZLogger(logLevel: LogLevel.INFO, message: e.toString()),
      //   );
      // }

      Future.microtask(() async {
        try {
          ZLogger(
            logLevel: LogLevel.IGNORE,
            message: "Zoncan Database was initialized!",
          );
          await zoncanDatabaseHelper.audit.setup();
        } catch (e) {
          ZLogger(
            logLevel: LogLevel.IGNORE,
            message: "Zoncan Database can't initialize!+ $e",
          );
        }

        zoncanDatabaseHelper.databaseFile.then((file) {
          ZLogger(
            logLevel: LogLevel.IGNORE,
            message: "Path of Database : ${file.path}",
          );
        });
      });

      appStateController.initState();

      return () {
        appStateController.dispose();
        // Consider if the database should be closed here or at a higher level
        // Injection.serviceLocator<ZoncanDatabase>().close();
      };
    }, [appStateController]); // Only depend on the controller's lifecycle

    final botToastBuilder = BotToastInit();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: TranslationsProvider.translator.appName,
      builder: (materialBuilderContext, child) {
        Widget reactChild = ReactionBuilder(
          builder: (reactionContext) {
            try {
              LocaleSettings.setLocaleRaw(
                appStateController.settings.locale ??
                    kDefaultLocale.languageCode,
              );
            } catch (ignore) {
              // Ignore
            }
            return autorun((_) async {
              try {
                LocaleSettings.setLocaleRaw(
                  appStateController.settings.locale ??
                      kDefaultLocale.countryCode!,
                );
              } catch (ignore) {
                // Ignore
              }
              Fonts.instance.fontScale =
                  appStateController.settings.fontScale ?? kDefaultUiScale;

              if (appStateController.isLoading) {
                LoadingScreen.instance.show(
                  context: reactionContext,
                  text: appStateController.loadingText,
                );
              } else {
                LoadingScreen.instance.hide(); // Ensure hide is called
              }

              if (appStateController.errorHappened) {
                appStateController.showMessage(
                  appStateController.exception!.userMessage!,
                );
                DialogHelper.showCrashReport(
                  reactionContext,
                  logger,
                  TranslationsProvider.translator.error,
                  appStateController.exception.toString(),
                );
              } else if (appStateController.exception != null &&
                  appStateController.exception!.justMessage) {
                appStateController.showMessage(
                  appStateController.exception!.userMessage!,
                );
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
            });
          },
          child: Observer(
            builder: (obsContext) {
              // The Observer will automatically rebuild when observable properties
              // within appStateController change.
              Fonts.instance.fontScale =
                  appStateController.settings.fontScale ?? kDefaultUiScale;
              return child ?? Container();
            },
          ),
        );

        return botToastBuilder(materialBuilderContext, reactChild);
      },
      locale: TranslationsProvider.localeOf(context),
      supportedLocales: TranslationsProvider.supportedLocales,
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: appStateController.themeMode,
      theme: Themizer.light,
      darkTheme: Themizer.dark,
      routeInformationParser: const QRouteInformationParser(),
      routerDelegate: QRouterDelegate(
        appInstanse.zRouter.routes,
        initPath: "/",
        navKey: NavigatorHelper.rootNavigatorKey,
        observers: [NavigatorHelper(), BotToastNavigatorObserver()],
      ),
    );
  }
}
