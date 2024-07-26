library zoncan.features.splash;

import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';

import '../../core/common/common.dart';

part 'presentation/pages/splash_page.dart';

part 'presentation/views/splash_view.dart';

class Splash {
  static Splash get get => Splash();

  QRoute get routes =>
      QRoute(path: Routing.to.splash.path, builder: () => const SplashPage());
}
