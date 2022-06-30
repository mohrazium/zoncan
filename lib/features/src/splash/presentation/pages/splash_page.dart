import 'package:flutter/material.dart';

import '../views/splash_view.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SplashView(),
    );

    // return HomeView();
  }
}
