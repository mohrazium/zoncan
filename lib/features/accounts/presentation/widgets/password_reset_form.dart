part of '../presentation.dart';

class PasswordRestForm extends StatefulWidget {
  const PasswordRestForm({
    super.key,
  });

  @override
  _PasswordRestFormState createState() => _PasswordRestFormState();
}

class _PasswordRestFormState extends State<PasswordRestForm> {
  final _passwordResetKeyController = TextEditingController();

  late String _passwordResetKey;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordResetKeyController.dispose();
    super.dispose();
  }

  doResetPassword() {
    setState(() {
      _passwordResetKey = _passwordResetKeyController.text;
      //TODO: do reset password
    });
    print('password reset key $_passwordResetKey'); //TODO:remove this
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
            translator.accounts.passwordReset,
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
                  TextBox(
                    titleText: translator.accounts.email,
                  ),
                ]),
          ),
          const SizedBox(height: kSpacing),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                translator.accounts.passwordReset,
              )),
          const SizedBox(height: kSpacing * 2),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: translator.accounts.login,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      QR.navigator.replaceAll(Routing.to.login.path);
                    },
                ),
              ],
            ),
          ),
        ]);
  }
}
