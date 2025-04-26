
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
                            // QR.navigator
                            //     .replaceAll(Routing.to.passwordReset.path);
                            DialogHelper.showMessageBox(
                              context: context,
                              title: TranslationsProvider.translator.error,
                              dialogButtons: DialogButtons.OK,
                              message: "appStateController.message!",
                              dialogType: DialogType.ERROR,
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
          builder:
              (_) => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading) {
                    LoadingScreen.instance.show(
                      context: context,
                      text: controller.loadingText ?? "",
                    );
                  } else {
                    LoadingScreen.instance.hide(); // Ensure hide is called
                  }

                  if (controller.errorHappened) {
                    controller.showMessage(controller.exception!.userMessage!);
                    DialogHelper.showCrashReport(
                      context,
                      logger,
                      TranslationsProvider.translator.error,
                      controller.exception.toString(),
                    );
                  } else if (controller.exception != null &&
                      controller.exception!.justMessage) {
                    controller.showMessage(controller.exception!.userMessage!);
                    await DialogHelper.showMessageBox(
                      context: context,
                      title: TranslationsProvider.translator.error,
                      dialogButtons: DialogButtons.OK,
                      message: controller.exception!.userMessage!,
                      dialogType: DialogType.ERROR,
                    ).then((value) {
                      controller.showMessage(null);
                    });
                  }
                  await controller.login();
                },
                child: Text(translator.accounts.login),
              ),
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
