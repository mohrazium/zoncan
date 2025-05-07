import 'dart:async';

import 'package:bot_toast/bot_toast.dart'
    show BotToastInit, BotToastNavigatorObserver;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:qlevar_router/qlevar_router.dart';

import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/common/common.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';

import 'app_state_controller.dart';
import 'application.dart';

late BuildContext baseContext;

class Zoncan extends HookWidget {
  const Zoncan({super.key});

  @override
  Widget build(BuildContext context) {
    final appInstanse = useMemoized(() => Application.instance);
    final appStateController = useMemoized(
      () => Injection.serviceLocator.get<AppStateController>(),
    );
    final zoncanDatabaseHelper = useMemoized(
      () => Injection.serviceLocator<ZoncanDatabase>(),
    );

final loadingDialogShown = useRef<bool>(false);
//!!!======================================================= 
    // // --- lifecycle Effect ---
    // useEffect(() {
    //   controller.initState();
    //   return () {
    //     controller.dispose();
    //   };
    // }, []);

    // // --- Reaction Effect for initial state ---
    // useEffect(() {
    //   final disposer = reaction((_) => controller.loginState.isInitial, (
    //     bool isInitial,
    //   ) async {
    //     if (isInitial) {}
    //   });
    //   return () {
    //     disposer();
    //   };
    // }, [controller, context]);

    // // --- Reaction Effect for Loading Dialog ---
    // useEffect(() {
    //   final disposer = reaction((_) => controller.loginState.isLoading, (
    //     bool isLoading,
    //   ) async {
    //     if (isLoading && !loadingDialogShown.value) {
    //       // Show Loading Dialog
    //       loadingDialogShown.value = true;
    //       DialogHelper.showLoading(
    //         context: context,
    //         loadingMessage: translator.loadingPleaseWait,
    //       );
    //     } else if (!isLoading && loadingDialogShown.value) {
    //       // Dismiss loading Dialog Only if it was shown by this reaction
    //       Navigator.of(context, rootNavigator: true).pop();
    //       loadingDialogShown.value = false; // Mark as dismissed
    //     }
    //     await Future.delayed(kDelayWaiting);
    //   });
    //   // Ensure dialog is dismissed if widget is disposed while loading
    //   return () {
    //     if (loadingDialogShown.value) {
    //       Navigator.of(context, rootNavigator: true).pop();
    //       loadingDialogShown.value = false;
    //     }
    //     disposer();
    //   };
    // }, [controller, context]);

    // // --- Reaction Effect for SUCCESS Dialog & Navigation ---
    // useEffect(() {
    //   final disposer = reaction((_) => controller.loginState.isSuccess, (
    //     bool isSuccess,
    //   ) async {
    //     // Make async for delay/navigation
    //     if (isSuccess) {
    //       // Ensure loading dialog is dismissed *before* showing success dialog
    //       if (loadingDialogShown.value) {
    //         Navigator.of(context, rootNavigator: true).pop();
    //         loadingDialogShown.value = false;
    //       }

    //       controller.clearForm(); // Clear form fields
    //       QR.navigator.replaceAll(
    //         Routing.to.dashboard.path,
    //       ); // Navigate to dashboard
    //       BotToast.showText(
    //         text: translator.accounts.loginSuccess,
    //         duration: kDelayWaiting,
    //       );
    //       await Future.delayed(kDelayWaiting);
    //       BotToast.showText(
    //         text: translator.welcome(fullName: controller.username),
    //         duration: Duration(milliseconds: 2000),
    //       );
    //       // Reset state (optional, depends if user can return here)
    //       // Do this *after* navigation is likely initiated
    //       controller.loginState.reset();

    //       // Maybe show the welcome BotToast *after* navigating to dashboard?
    //       // This belongs in the Dashboard screen's init logic ideally.
    //     }
    //   });
    //   return () => disposer();
    // }, [controller, context]); // Add context dependency

    // // --- Reaction Effect for ERROR Dialog ---
    // useEffect(() {
    //   final disposer = reaction(
    //     (_) =>
    //         controller.loginState.exception, // React to changes in controller
    //     (FailureException? error) {
    //       if (error != null) {
    //         // 1. Show user-friendly dialog (using errorMessage computed property)
    //         DialogHelper.showMessageBox(
    //           context: context,
    //           title: TranslationsProvider.translator.error,
    //           dialogButtons: DialogButtons.OK,
    //           message:
    //               controller.loginState.exception!.userMessage ??
    //               "An error occurred.", // Use computed property
    //           dialogType: DialogType.ERROR,
    //         ).then((_) {
    //           // Optional: Reset state after dialog dismissed
    //           controller.loginState.reset();
    //         });

    //         // 2. Prepare for or send crash report (using rawError and stackTrace)
    //         // print(">>> Crash Report Prep <<<");
    //         // print("Error Type: ${errorDetails.originalError.runtimeType}");
    //         // print("Original Error: ${errorDetails.originalError}"); // The actual Exception/Error
    //         // print("Stack Trace: ${errorDetails.stackTrace}"); // The stack trace

    //         // --- Example: Integration with a crash reporting service ---
    //         // if (kReleaseMode) { // Only report in release mode
    //         //   CrashReportingService.instance.recordError(
    //         //     errorDetails.originalError, // Pass the original error
    //         //     errorDetails.stackTrace,    // Pass the stack trace
    //         //     reason: 'Login failed: ${errorDetails.userMessage}', // Optional context
    //         //     // You might include additional context like username (if allowed by privacy)
    //         //     // information: {'username': controller.username}
    //         //   );
    //         // }
    //         // --- End Example ---
    //       }
    //     },
    //   );
    //   return () => disposer(); // Cleanup reaction
    // }, [controller, context]); // Depend on controller instance
    // // --- Reaction Effect for ERROR Dialog ---
    // useEffect(() {
    //   final disposer = reaction(
    //     (_) => controller.exception, // React to changes in controller
    //     (FailureException? error) {
    //       if (error != null) {
    //         // 1. Show user-friendly dialog (using errorMessage computed property)
    //         DialogHelper.showMessageBox(
    //           context: context,
    //           title: TranslationsProvider.translator.error,
    //           dialogButtons: DialogButtons.OK,
    //           message:
    //               controller.exception!.userMessage ??
    //               "An error occurred.", // Use computed property
    //           dialogType: DialogType.ERROR,
    //         ).then((_) {
    //           // Optional: null exception set after dialog dismissed
    //           controller.exception = null;
    //         });
    //       }
    //     },
    //   );
    //   return () => disposer(); // Cleanup reaction
    // }, [controller, context]); // Depend on controller instance
//!!!======================================================= 

    useEffect(() {
      logger.setup();

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
        zoncanDatabaseHelper.close();
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
        baseContext = materialBuilderContext;

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
        navKey: mainNavigatorKey,
        observers: [NavigatorHelper(), BotToastNavigatorObserver()],
      ),
    );
  }
}
