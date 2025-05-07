import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/common/common.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';

import '../controllers/login_controller.dart';
import '../widgets/login_header.dart';

class LoginForm extends HookWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => Injection.serviceLocator.get<LoginController>(),
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
      return null;
    }, [controller]);

    // --- Reaction Effect for initial state ---
    useEffect(() {
      final disposer = reaction((_) => controller.loginState.isInitial, (
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
      final disposer = reaction((_) => controller.loginState.isLoading, (
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
      final disposer = reaction((_) => controller.loginState.isSuccess, (
        bool isSuccess,
      ) async {
        // Make async for delay/navigation
        if (isSuccess) {
          // Ensure loading dialog is dismissed *before* showing success dialog
          if (loadingDialogShown.value) {
            Navigator.of(context, rootNavigator: true).pop();
            loadingDialogShown.value = false;
          }

          controller.clearForm(); // Clear form fields
          QR.navigator.replaceAll(
            Routing.to.dashboard.path,
          ); // Navigate to dashboard
          BotToast.showText(
            text: translator.accounts.loginSuccess,
            duration: kDelayWaiting,
          );
          await Future.delayed(kDelayWaiting);
          BotToast.showText(
            text: translator.welcome(fullName: controller.userDetails!.nickName!),
            duration: Duration(milliseconds: 2000),
          );
          // Reset state (optional, depends if user can return here)
          // Do this *after* navigation is likely initiated
          controller.loginState.reset();

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
            controller.loginState.exception, // React to changes in controller
        (FailureException? error) {
          if (error != null) {
            // 1. Show user-friendly dialog (using errorMessage computed property)
            DialogHelper.showMessageBox(
              context: context,
              title: TranslationsProvider.translator.error,
              dialogButtons: DialogButtons.OK,
              message:
                  controller.loginState.exception!.userMessage ??
                  "An error occurred.", // Use computed property
              dialogType: DialogType.ERROR,
            ).then((_) {
              // Optional: Reset state after dialog dismissed
              controller.loginState.reset();
            });

            // 2. Prepare for or send crash report (using rawError and stackTrace)
            // print(">>> Crash Report Prep <<<");
            // print("Error Type: ${errorDetails.originalError.runtimeType}");
            // print("Original Error: ${errorDetails.originalError}"); // The actual Exception/Error
            // print("Stack Trace: ${errorDetails.stackTrace}"); // The stack trace

            // --- Example: Integration with a crash reporting service ---
            // if (kReleaseMode) { // Only report in release mode
            //   CrashReportingService.instance.recordError(
            //     errorDetails.originalError, // Pass the original error
            //     errorDetails.stackTrace,    // Pass the stack trace
            //     reason: 'Login failed: ${errorDetails.userMessage}', // Optional context
            //     // You might include additional context like username (if allowed by privacy)
            //     // information: {'username': controller.username}
            //   );
            // }
            // --- End Example ---
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const LoginHeader(),
        Text(
          translator.accounts.login,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: kSpacing),
        Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Observer(
                builder:
                    (_) => TextBox(
                      controller: controller.usernameController,
                      errorText: controller.validator.usernameError,
                      onChanged: (value) => controller.username = value,
                      suffixWidget: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: controller.isUsernameAbilityPending ? 1 : 0,
                        child: LoadingAnimationWidget.beat(
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                      ),
                      autofocus: true,
                      titleText: translator.accounts.userNameEmail,
                    ),
              ),
              Observer(
                builder:
                    (_) => TextBox(
                      controller: controller.passwordController,
                      errorText: controller.validator.passwordError,
                      onChanged: (value) => controller.password = value,
                      titleText: translator.accounts.password,
                      isSecure: true,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: kSpacing),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Observer(
                  builder:
                      (_) => Checkbox(
                        onChanged:
                            (onChanged) =>
                                controller.changeRememberMe(onChanged!),
                        value: controller.rememberMe,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(translator.accounts.rememberMe),
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: translator.accounts.forgetPassword,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            QR.navigator.replaceAll(
                              Routing.to.passwordReset.path,
                            );
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: kSpacing),
        Observer(
          builder: (_) {
            final bool canPress = !controller.loginState.isLoading;
            return ElevatedButton(
              onPressed:
                  canPress
                      ? () async {
                        await controller.login();
                      }
                      : null,
              child: Text(translator.accounts.login),
            );
          },
        ),
        const SizedBox(height: kSpacing * 2),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: translator.accounts.noAccountYet,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextSpan(
                text: translator.accounts.registerNow,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        QR.navigator.replaceAll(Routing.to.signup.path);
                      },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

showLoadingddd(String loadingText) {
  final stText = StreamController<String>();
  stText.add(loadingText);
  if (mainNavigatorKey.currentState != null &&
      mainNavigatorKey.currentState!.context.mounted) {
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: mainNavigatorKey.currentState!.context,
      builder: (BuildContext context) {
        return Material(
          color: Theme.of(context).colorScheme.shadow.withAlpha(150),
          child: Center(
            child: GroupBox(
              width: 250,
              height: 250,
              padding: const EdgeInsets.all(kPadding),
              margin: const EdgeInsets.all(kMargin),
              color: Theme.of(context).cardColor,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: kSpacing),
                      LoadingAnimationWidget.discreteCircle(
                        color: Theme.of(context).colorScheme.primary,
                        secondRingColor:
                            Theme.of(context).colorScheme.secondary,
                        thirdRingColor: Theme.of(context).colorScheme.tertiary,
                        size: 50 * Fonts.instance.fontScale,
                      ),
                      const SizedBox(height: kSpacing),
                      StreamBuilder(
                        stream: stText.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data as String,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
