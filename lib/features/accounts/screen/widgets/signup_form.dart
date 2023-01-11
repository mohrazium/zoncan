part of zoncan.features.accounts.screen;

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final SignupController controller = Modular.get<SignupController>();

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
    return SingleChildScrollView(
      child: Observer(builder: (obsContext) {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const LoginHeader(),
                Text(
                  translator.login.signup,
                  style: Theme.of(obsContext)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Observer(builder: (_) {
                  return TextBox(
                    autofocus: true,
                    controller: controller.nickNameTextController,
                    onChanged: (value) => controller.nickName = value,
                    errorText: controller.validator.nickNameError,
                    titleText: translator.fullName,
                    isRequired: true,
                  );
                }),
                Observer(builder: (_) {
                  return TextBox(
                    controller: controller.emailTextController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => controller.email = value,
                    errorText: controller.validator.emailError,
                    titleText: translator.login.email,
                    suffixWidget: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: controller.isEmailCheckPending ? 1 : 0,
                        child: LoadingAnimationWidget.beat(
                            color: Theme.of(context).colorScheme.primary,
                            size: 24)),
                    isRequired: true,
                  );
                }),
                Observer(builder: (_) {
                  return TextBox(
                    controller: controller.passwordTextController,
                    onChanged: (value) => controller.password = value,
                    errorText: controller.validator.passwordError,
                    titleText: translator.login.password,
                    isSecure: true,
                    isRequired: true,
                  );
                }),
                Observer(builder: (_) {
                  return TextBox(
                    controller: controller.confirmPasswordTextController,
                    onChanged: (value) => controller.confirmPassword = value,
                    errorText: controller.validator.confirmPasswordError,
                    titleText: translator.login.passwordConfirmation,
                    isSecure: true,
                  );
                }),
                const SizedBox(height: kSpacing),
                ElevatedButton(
                    onPressed: () async {
                      await controller.signup().then((value) async {
                        if (value) {
                          BotToast.showText(text: t.login.signupSuccess);
                          Modular.to.navigate(Routing.to.login.path);
                          await Future.delayed(kDelayWaiting);
                          BotToast.showText(text: t.login.loggedIn);
                        } else {
                          BotToast.showText(text: t.login.signupFail);
                        }
                      });
                    },
                    child: Text(
                      translator.login.signup,
                    )),
                const SizedBox(height: kSpacing / 2),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: translator.login.haveAccount,
                        style: Theme.of(obsContext).textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text: translator.login.loggedIn,
                        style: Theme.of(obsContext)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Modular.to.navigate(Routing.to.login.path);
                          },
                      ),
                    ],
                  ),
                ),
              ]),
        );
      }),
    );
  }
}
