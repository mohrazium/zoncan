part of zoncan.features.login;

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isRem = false;

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
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: kSpacing),
          Form(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextBox(
                    titleText: translator.login.userNameEmail,
                  ),
                  TextBox(
                    titleText: translator.login.password,
                    isSecure: true,
                  ),
                ]),
          ),
          const SizedBox(height: kSpacing),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                //TODO: declare rememberMe in controller
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      onChanged: (onChanged) {
                        setState(() {
                          isRem = onChanged!;
                        });
                      },
                      value: isRem,
                    ),
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
              onPressed: () {},
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
