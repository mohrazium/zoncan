// part of '../presentation.dart';
//
// class LoginForm extends StatefulWidget {
//   const LoginForm({super.key});
//
//   @override
//   State<LoginForm> createState() => _LoginFormState();
// }
//
// class _LoginFormState extends State<LoginForm> {
//   final LoginController controller =
//       Injection.serviceLocator.get<LoginController>();
//
//   @override
//   void initState() {
//     super.initState();
//     controller.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     controller.didChangeDependencies();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var translator = TranslationsProvider.translator;
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           const LoginHeader(),
//           Text(
//             translator.accounts.login,
//             style: Theme.of(context)
//                 .textTheme
//                 .titleLarge
//                 ?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: kSpacing),
//           Form(
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Observer(
//                       builder: (_) => TextBox(
//                             controller: controller.usernameController,
//                             errorText: controller.validator.usernameError,
//                             onChanged: (value) => controller.username = value,
//                             suffixWidget: AnimatedOpacity(
//                                 duration: const Duration(milliseconds: 300),
//                                 opacity:
//                                     controller.isUsernameAbilityPending ? 1 : 0,
//                                 child: LoadingAnimationWidget.beat(
//                                     color:
//                                         Theme.of(context).colorScheme.primary,
//                                     size: 24)),
//                             autofocus: true,
//                             titleText: translator.accounts.userNameEmail,
//                           )),
//                   Observer(
//                       builder: (_) => TextBox(
//                             controller: controller.passwordController,
//                             errorText: controller.validator.passwordError,
//                             onChanged: (value) => controller.password = value,
//                             titleText: translator.accounts.password,
//                             isSecure: true,
//                           ))
//                 ]),
//           ),
//           const SizedBox(height: kSpacing),
//           Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Observer(
//                         builder: (_) => Checkbox(
//                               onChanged: (onChanged) =>
//                                   controller.changeRememberMe(onChanged!),
//                               value: controller.rememberMe,
//                             )),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
//                       child: Text(translator.accounts.rememberMe),
//                     ),
//                   ],
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: translator.accounts.forgetPassword,
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyMedium
//                             ?.copyWith(color: Colors.blue),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             QR.navigator.replaceAll(Routing.to.passwordReset.path);
//                           },
//                       ),
//                     ],
//                   ),
//                 ),
//               ]),
//           const SizedBox(height: kSpacing),
//           ElevatedButton(
//               onPressed: () async {
//                 await controller.login();
//               },
//               child: Text(
//                 translator.accounts.login,
//               )),
//           const SizedBox(height: kSpacing * 2),
//           RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: translator.accounts.noAccountYet,
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//                 TextSpan(
//                   text: translator.accounts.registerNow,
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyMedium
//                       ?.copyWith(color: Colors.blue),
//                   recognizer: TapGestureRecognizer()
//                     ..onTap = () {
//                       QR.navigator.replaceAll(Routing.to.signup.path);
//                     },
//                 ),
//               ],
//             ),
//           ),
//         ]);
//   }
// }
