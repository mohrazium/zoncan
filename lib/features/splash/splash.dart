library zoncan.features.splash;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';

import '../../core/common/common.dart';

part 'presentation/pages/splash_page.dart';

part 'presentation/views/splash_view.dart';

class Splash {
  static Splash get get => Splash();

  QRoute get routes => // مسیر Splash (بدون پوسته)
      QRoute(
        path: Routing.to.splash.path,
        name: Routing.to.splash.named, // نام را هم تعریف کنید
        builder: () => const SplashPage(),
      );
}
