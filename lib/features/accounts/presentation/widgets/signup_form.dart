part of zoncan.features.accounts.presentation;

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
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
              onPressed: () {
                //TODO: Create confirm code view, this acceptance of signup or password reset
              },
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
