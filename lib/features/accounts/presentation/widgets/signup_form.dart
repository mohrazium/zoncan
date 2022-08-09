part of zoncan.features.login;

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    var translator = Translations.of(context);
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
          const LoginHeader(),
          Text(
            translator.login.signup,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Form(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextBox(
                    titleText: translator.fullName,
                  ),
                  TextBox(
                    titleText: translator.login.userNameEmail,
                  ),
                  TextBox(
                    titleText: translator.login.password,
                    isSecure: true,
                  ),
                  TextBox(
                    titleText: translator.login.passwordConfirmation,
                    isSecure: true,
                  ),
                ]),
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                translator.login.signup,
              )),
          const SizedBox(height: kSpacing / 2),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${translator.login.haveAccount} ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text: translator.login.loggedIn,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Modular.to.navigate(Routing.routes().login.path);
                    },
                ),
              ],
            ),
          ),
        ]));
  }
}
