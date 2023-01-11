library zoncan.features.home;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:floy/floy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zoncan/app/app.dart';
import 'package:zoncan/common/common.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/localization/localization.dart';
import 'package:zoncan/security/security.dart';

part 'screen/pages/home_page.dart';
part 'screen/views/home_view_large.dart';
part 'screen/pages/setup_page.dart';
part 'screen/views/setup_view.dart';

class Home extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
