part of '../presentation.dart';


class ProfileForm extends Hooks.HookWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Hooks.useMemoized(
        () => Injection.serviceLocator.get<ProfileController>());

    final translator = Hooks.useMemoized(() => TranslationsProvider.translator);

    Hooks.useEffect(() {
      controller.initState();
      return () {
        controller.dispose();
      };
    }, []);

    Hooks.useEffect(() {
      controller.didChangeDependencies();
      return null;
    }, [controller]);
    return ElevatedButton(
        onPressed: () async {
          await controller.logout();
        },
        child: Text(
          translator.accounts.login,
        ));
  }
}
