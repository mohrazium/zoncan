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

import '../controllers/signup_controller.dart';
import '../widgets/login_header.dart';

class SignupForm extends HookWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => Injection.serviceLocator.get<SignupController>(),
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
      final disposer = reaction((_) => controller.signUpState.isInitial, (
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
      final disposer = reaction((_) => controller.signUpState.isLoading, (
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
      final disposer = reaction((_) => controller.signUpState.isSuccess, (
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
            text: translator.accounts.signupSuccess,
            duration: kDelayWaiting,
          );
          await Future.delayed(kDelayWaiting);
          BotToast.showText(
            text: translator.welcome(
              fullName: controller.userDetails.nickName!,
            ),
            duration: Duration(milliseconds: 2000),
          );
          // Reset state (optional, depends if user can return here)
          // Do this *after* navigation is likely initiated
          controller.signUpState.reset();

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
            controller.signUpState.exception, // React to changes in controller
        (FailureException? error) {
          if (error != null) {
            // 1. Show user-friendly dialog (using errorMessage computed property)
            DialogHelper.showMessageBox(
              context: context,
              title: TranslationsProvider.translator.error,
              dialogButtons: DialogButtons.OK,
              message:
                  controller.signUpState.exception!.userMessage ??
                  "An error occurred.", // Use computed property
              dialogType: DialogType.ERROR,
            ).then((_) {
              // Optional: Reset state after dialog dismissed
              controller.signUpState.reset();
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

    return SingleChildScrollView(
      child: Observer(
        builder: (obsContext) {
          return Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const LoginHeader(),
                Text(
                  translator.accounts.signup,
                  style: Theme.of(
                    obsContext,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Observer(
                  builder: (_) {
                    return TextBox(
                      autofocus: true,
                      controller: controller.nickNameTextController,
                      onChanged: (value) => controller.nickName = value,
                      errorText: controller.validator.nickNameError,
                      titleText: translator.fullName,
                      isRequired: true,
                    );
                  },
                ),
                Observer(
                  builder: (_) {
                    return TextBox(
                      controller: controller.emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => controller.email = value,
                      errorText: controller.validator.emailError,
                      titleText: translator.accounts.email,
                      suffixWidget: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: controller.isEmailCheckPending ? 1 : 0,
                        child: LoadingAnimationWidget.beat(
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                      ),
                      isRequired: true,
                    );
                  },
                ),
                Observer(
                  builder: (_) {
                    return TextBox(
                      controller: controller.passwordTextController,
                      onChanged: (value) => controller.password = value,
                      errorText: controller.validator.passwordError,
                      titleText: translator.accounts.password,
                      isSecure: true,
                      isRequired: true,
                    );
                  },
                ),
                Observer(
                  builder: (_) {
                    return TextBox(
                      controller: controller.confirmPasswordTextController,
                      onChanged: (value) => controller.confirmPassword = value,
                      errorText: controller.validator.confirmPasswordError,
                      titleText: translator.accounts.passwordConfirmation,
                      isSecure: true,
                    );
                  },
                ),
                const SizedBox(height: kSpacing),
                Observer(
                  builder: (_) {
                    final bool canPress = !controller.signUpState.isLoading;
                    return ElevatedButton(
                      onPressed:
                          canPress
                              ? () async {
                                await controller.signup();
                              }
                              : null,
                      child: Text(translator.accounts.signup),
                    );
                  },
                ),
                const SizedBox(height: kSpacing / 2),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: translator.accounts.haveAccount,
                        style: Theme.of(obsContext).textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text: translator.accounts.loggedIn,
                        style: Theme.of(
                          obsContext,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () =>QR
                                  .navigatorOf(Routing.to.accounts.named)
                                  .switchTo(Routing.to.login.named),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
