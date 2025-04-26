
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zoncan/config/config.dart';

import '../controllers/profile_controller.dart';



class ProfileForm extends HookWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
        () => Injection.serviceLocator.get<ProfileController>());

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
    return ElevatedButton(
        onPressed: () async {
          await controller.logout();
        },
        child: Text(
          translator.accounts.login,
        ));
  }
}
