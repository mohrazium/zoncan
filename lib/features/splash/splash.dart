library zoncan.features.splash;

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/localization/localization.dart';

import '../../common/common.dart';

part 'screen/pages/splash_page.dart';

class Splash extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => SplashPage(args.data)),
      ];
}
