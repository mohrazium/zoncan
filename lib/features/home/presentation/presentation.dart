library zoncan.features.home.presentaion;

import 'package:bot_toast/bot_toast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:floy/floy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:qlevar_router/qlevar_router.dart';

import 'package:zoncan/app/app.dart';
import 'package:zoncan/core/common/common.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/config/src/constants/constants.dart';
import 'package:zoncan/config/src/localization/localization.dart';
import 'package:zoncan/core/security/security.dart';

part 'controllers/home_controller.dart';
part 'views/first_setup_view.dart';
part 'views/home_view_large.dart';
part 'widgets/app_bar.dart';
part 'pages/first_setup_page.dart';
part 'pages/dashboard_page.dart';
part 'pages/home_page.dart';

part "presentation.g.dart";
