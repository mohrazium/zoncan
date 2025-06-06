// ignore_for_file: use_build_context_synchronously

import 'package:bot_toast/bot_toast.dart';
import 'package:floy/floy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobx/mobx.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart' show kDelayWaiting;
import 'package:zoncan/config/src/injection/service_locator.dart';
import 'package:zoncan/config/src/localization/localization.dart';
import 'package:zoncan/config/src/router/routes.dart';
import 'package:zoncan/core/common/common.dart'
    show DialogButtons, DialogHelper, DialogResult, DialogType;
import 'package:zoncan/core/exceptions/exceptions.dart';
import 'package:zoncan/features/home/presentation/controllers/home_controller.dart';
import 'package:zoncan/features/home/presentation/widgets/profile_popup.dart';
import 'package:zoncan/features/home/presentation/widgets/side_panel.dart';
import 'package:zoncan/features/wizard/wizard.dart';

class HomeView extends HookWidget {
  final Widget child;
  const HomeView({required this.child, super.key});

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
      Future.microtask(() async {
        // if (!controller.isCompletedFirstSetup) {
        //   var res = await DialogHelper.showMessageBox(
        //     context: context,
        //     title: "title",
        //     message: "message",
        //     dialogType: DialogType.INFO,
        //     dialogButtons: DialogButtons.OK,
        //   );
        //   if (res == DialogResult.OK) {
        //     DialogHelper.show(context: context, title: "title",child: SetupWizard());
        //   }
        // }
      });
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

    return Floy(
      fullHeightSidePanels: true,
      leftPanel: SidePanel(controller: controller),
      appBar: AppBar(
        toolbarHeight: 60 * controller.appStateController.scaleFactor,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
            ],
          ),
          child: Row(
            children: [
              // Search Bar
              Expanded(
                child: Container(
                  height: 36,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('Search', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),

              // Action Icons
              IconButton(
                icon: Icon(Icons.settings_outlined),
                onPressed: () {
                  QR.navigator.replaceAll(Routing.to.firstSetup.path);
                },
                color: Colors.grey,
              ),
              IconButton(
                icon: Icon(Icons.calendar_today_outlined),
                onPressed: () {},
                color: Colors.grey,
              ),
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_outlined),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '2',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.message_outlined),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '3',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {},
                color: Colors.grey,
              ),
              ProfilePopup(controller: controller),
              AccountSwitcherWidget(),
              Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ),
      body: child,
    );
  }
}

        // title: Row(
        //   mainAxisSize: MainAxisSize.max,
        //   children: <Widget>[

        //
        //     Observer(
        //       builder: (_) {
        //         return Transform.scale(
        //           scale: controller.appStateController.scaleFactor,
        //           child: ToolbarIconButton(
        //             onTap: () {
        //               controller.appStateController.increaseScale();
        //             },
        //             icon: const Icon(
        //               Icons.text_increase,
        //               color: Colors.deepPurpleAccent,
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //     Observer(
        //       builder: (_) {
        //         return Transform.scale(
        //           scale: controller.appStateController.scaleFactor,
        //           child: ToolbarIconButton(
        //             onTap: () {
        //               controller.appStateController.decreaseScale();
        //             },
        //             icon: const Icon(
        //               Icons.text_decrease,
        //               color: Colors.deepPurpleAccent,
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //     Expanded(child: Container()),

        //     /// ToDO : move this consept to show avatar and profile button
        //     Observer(
        //       builder:
        //           (_) =>
        //               !controller
        //                       .appStateController
        //                       .currentUserState
        //                       .isLoading
        //                   ? Transform.scale(
        //                     scale: controller.appStateController.scaleFactor,
        //                     child: Text(
        //                       translator.welcome(
        //                         fullName:
        //                             controller
        //                                 .appStateController
        //                                 .currentUser!
        //                                 .nickName ??
        //                             "no name",
        //                       ),
        //                       style: const TextStyle(color: Colors.blueGrey),
        //                     ),
        //                   )
        //                   : Transform.scale(
        //                     scale: controller.appStateController.scaleFactor,
        //                     child: Padding(
        //                       padding: EdgeInsets.all(kPadding),
        //                       child: CircularProgressIndicator(),
        //                     ),
        //                   ),
        //     ),
        //   ],
        // ),