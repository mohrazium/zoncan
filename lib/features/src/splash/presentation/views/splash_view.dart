import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zoncan/app/app.dart' show Routes;
import 'package:zoncan/common/common.dart' show Splash;

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((s) {
      Modular.to.navigate(Routes.home.path);
    });

    return const Splash.show(
      title: Text("title"),
      loadingText: Text("loading"),
    );
  }
}
