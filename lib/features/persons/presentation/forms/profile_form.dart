// part of '../presentation.dart';
//
// class ProfileForm extends StatefulWidget {
//   const ProfileForm({super.key});
//
//   @override
//   State<ProfileForm> createState() => _ProfileFormState();
// }
//
// class _ProfileFormState extends State<ProfileForm> {
//   final ProfileController controller =
//   Injection.serviceLocator.get<ProfileController>();
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
//
//     return ElevatedButton(
//         onPressed: () async {
//           await controller.logout();
//         },
//         child: Text(
//           translator.accounts.login,
//         ));
//   }
// }
