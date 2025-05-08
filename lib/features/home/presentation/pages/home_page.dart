import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/app/src/app_state_controller.dart';
import 'package:zoncan/config/config.dart' show kDelayWaiting, kPadding;
import 'package:zoncan/config/src/injection/service_locator.dart';
import 'package:zoncan/config/src/localization/localization.dart';
import 'package:zoncan/config/src/router/routes.dart';
import 'package:zoncan/core/common/common.dart'
    show DialogButtons, DialogHelper, DialogType, DialogResult;
import 'package:zoncan/core/common/components/widgets/toolbar_icon_button.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';
import 'package:zoncan/features/accounts/data/datasource/local/daos/user_details_dao.dart';
import 'package:zoncan/features/accounts/data/models/user_details_model.dart';
import 'package:zoncan/features/home/presentation/controllers/home_controller.dart';
import 'package:zoncan/features/home/presentation/views/home_view.dart';

class HomePage extends HookWidget {
  final Widget child; // محتوای داخلی (داشبورد، محصولات و ...)

  const HomePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => Injection.serviceLocator<HomeController>(),
    );

    final translator = useMemoized(() => TranslationsProvider.translator);

    final loadingDialogShown = useRef<bool>(false);
    // --- lifecycle Effect ---
    useEffect(() {
      controller.initState();
      return () {
        controller.dispose();
      };
    }, []);

    useEffect(() {
      controller.didChangeDependencies();
      Future.microtask(() async {});
      return null;
    }, [controller]);

    // --- Reaction Effect for initial state ---
    useEffect(() {
      final disposer = reaction((_) => controller.logoutState.isInitial, (
        bool isInitial,
      ) async {
        if (isInitial) {}
      });
      return () {
        disposer();
      };
    }, [controller, context]);

    // --- Reaction Effect for Loading Dialog ---
    useEffect(() {
      final disposer = reaction((_) => controller.logoutState.isLoading, (
        bool isLoading,
      ) async {
        if (isLoading && !loadingDialogShown.value) {
          // Show Loading Dialog
          loadingDialogShown.value = true;
          DialogHelper.showLoading(
            context: context,
            loadingMessage: translator.loadingPleaseWait,
          );
        } else if (!isLoading && loadingDialogShown.value) {
          // Dismiss loading Dialog Only if it was shown by this reaction
          Navigator.of(context, rootNavigator: true).pop();
          loadingDialogShown.value = false; // Mark as dismissed
        }
        await Future.delayed(kDelayWaiting);
      });
      // Ensure dialog is dismissed if widget is disposed while loading
      return () {
        if (loadingDialogShown.value) {
          Navigator.of(context, rootNavigator: true).pop();
          loadingDialogShown.value = false;
        }
        disposer();
      };
    }, [controller, context]);

    // --- Reaction Effect for SUCCESS Dialog & Navigation ---
    useEffect(() {
      final disposer = reaction((_) => controller.logoutState.isSuccess, (
        bool isSuccess,
      ) async {
        // Make async for delay/navigation
        if (isSuccess) {
          // Ensure loading dialog is dismissed *before* showing success dialog
          if (loadingDialogShown.value) {
            Navigator.of(context, rootNavigator: true).pop();
            loadingDialogShown.value = false;
          }

          QR.navigator.replaceAll(Routing.to.login.path);
          BotToast.showText(text: translator.accounts.loggedOut);
          // Reset state (optional, depends if user can return here)
          // Do this *after* navigation is likely initiated
          controller.logoutState.reset();

          // Maybe show the welcome BotToast *after* navigating to dashboard?
          // This belongs in the Dashboard screen's init logic ideally.
        }
      });
      return () => disposer();
    }, [controller, context]); // Add context dependency

    // --- Reaction Effect for ERROR Dialog ---
    useEffect(() {
      final disposer = reaction(
        (_) =>
            controller.logoutState.exception, // React to changes in controller
        (FailureException? error) {
          if (error != null) {
            // 1. Show user-friendly dialog (using errorMessage computed property)
            DialogHelper.showMessageBox(
              context: context,
              title: TranslationsProvider.translator.error,
              dialogButtons: DialogButtons.OK,
              message:
                  controller.logoutState.exception!.userMessage ??
                  "An error occurred.", // Use computed property
              dialogType: DialogType.ERROR,
            ).then((_) {
              // Optional: Reset state after dialog dismissed
              controller.logoutState.reset();
            });
          }
        },
      );
      return () => disposer(); // Cleanup reaction
    }, [controller, context]); // Depend on controller instance
    // --- Reaction Effect for ERROR Dialog ---
    useEffect(() {
      final disposer = reaction(
        (_) => controller.exception, // React to changes in controller
        (FailureException? error) {
          if (error != null) {
            // 1. Show user-friendly dialog (using errorMessage computed property)
            DialogHelper.showMessageBox(
              context: context,
              title: TranslationsProvider.translator.error,
              dialogButtons: DialogButtons.OK,
              message:
                  controller.exception!.userMessage ??
                  "An error occurred.", // Use computed property
              dialogType: DialogType.ERROR,
            ).then((_) {
              // Optional: null exception set after dialog dismissed
              controller.exception = null;
            });
          }
        },
      );
      return () => disposer(); // Cleanup reaction
    }, [controller, context]); // Depend on controller instance

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          title: Row(
            children: <Widget>[
              Observer(
                builder: (_) {
                  final bool canPress = !controller.logoutState.isLoading;
                  return ToolbarIconButton(
                    onTap:
                        canPress
                            ? () async {
                              final res = await DialogHelper.showMessageBox(
                                context: context,
                                title: translator.accounts.logout,
                                message: translator.accounts.sureToLogout,
                                dialogType: DialogType.WARNING,
                                dialogButtons: DialogButtons.YES_NO,
                              );
                              if (res == DialogResult.YES) {
                                await controller.logoutUser();
                              }
                            }
                            : null,
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.deepPurpleAccent,
                    ),
                  );
                },
              ),
              Expanded(child: Container()),

              /// ToDO : move this consept to show avatar and profile button
              Observer(
                builder:
                    (_) =>
                        !controller
                                .appStateController
                                .currentUserState
                                .isLoading
                            ? Text(
                              translator.welcome(
                                fullName:
                                    controller
                                        .appStateController
                                        .currentUser!
                                        .nickName ??
                                    "no name",
                              ),
                              style: const TextStyle(color: Colors.blueGrey),
                            )
                            : Padding(
                              padding: EdgeInsets.all(kPadding),
                              child: CircularProgressIndicator(),
                            ),
              ),
            ],
          ),
        ),
        body: HomeView(child: child),
      ),
    );
  }
}
