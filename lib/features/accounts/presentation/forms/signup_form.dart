
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/common/common.dart';

import '../controllers/login_controller.dart';
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
                ElevatedButton(
                  onPressed: () async {
                    await controller.signup();
                  },
                  child: Text(translator.accounts.signup),
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
                              ..onTap = () {
                                QR.navigator.replaceAll(Routing.to.login.path);
                              },
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
