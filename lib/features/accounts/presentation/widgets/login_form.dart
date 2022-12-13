part of zoncan.features.accounts.presentation;

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final LoginController controller = Modular.get<LoginController>();

  @override
  void initState() {
    super.initState();
    controller.initState();
  }

  @override
  void didChangeDependencies() {
    controller.didChangeDependencies();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var translator = Translations.of(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const LoginHeader(),
          Text(
            translator.login.login,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: kSpacing),
          Form(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Observer(
                      builder: (_) => TextBox(
                            controller: controller.usernameController,
                            errorText: controller.validator.usernameError,
                            onChanged: (value) => controller.username = value,
                            suffixWidget: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity:
                                    controller.isUsernameAbilityPending ? 1 : 0,
                                child: LoadingAnimationWidget.beat(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 24)),
                            autofocus: true,
                            titleText: translator.login.userNameEmail,
                          )),
                  Observer(
                      builder: (_) => TextBox(
                            controller: controller.passwordController,
                            errorText: controller.validator.passwordError,
                            onChanged: (value) => controller.password = value,
                            titleText: translator.login.password,
                            isSecure: true,
                          ))
                ]),
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
                        builder: (_) => Checkbox(
                              onChanged: (onChanged) =>
                                  controller.changeRememberMe(onChanged!),
                              value: controller.rememberMe,
                            )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(translator.login.rememberMe),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: translator.login.forgetPassword,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Modular.to
                                .navigate(Routing.routes().passwordReset.path);
                          },
                      ),
                    ],
                  ),
                ),
              ]),
          const SizedBox(height: kSpacing),
          ElevatedButton(
              onPressed: () async {

                  await controller.login().then((value) async {
                  if (value) {
                    BotToast.showText(text: t.login.loginSuccess);
                    Modular.to.navigate(Routing.routes().home.path);
                    await Future.delayed(kDelayWaiting);
                    BotToast.showText(text: t.login.loggedIn);
                  } else {
                    BotToast.showText(text: t.login.loginFail);
                                    Modular.to.navigate(Routing.routes().home.path);

                  }
                });
              },
              child: Text(
                translator.login.login,
              )),
          const SizedBox(height: kSpacing * 2),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: translator.login.noAccountYet,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text: translator.login.registerNow,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Modular.to.navigate(Routing.routes().signup.path);
                    },
                ),
              ],
            ),
          ),
        ]);
  }
}
