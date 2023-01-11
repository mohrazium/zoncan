library zoncan.features.accounts.screen;

import 'dart:math';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:floy/floy.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:validators2/validators.dart';

import 'package:zoncan/app/app.dart' show AppStateController;
import 'package:zoncan/common/common.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/constants/constants.dart';
import 'package:zoncan/features/features.dart';
import 'package:zoncan/localization/localization.dart';
import 'package:zoncan/security/security.dart';
import 'package:zoncan/utils/utils.dart';

part 'controllers/signup_controller.dart';
part 'pages/accounts_page.dart';
part 'screen.g.dart';
part 'views/accounts_view_large.dart';
part 'widgets/login_form.dart';
part 'widgets/login_header.dart';
part 'widgets/password_reset_form.dart';
part 'widgets/signup_form.dart';
part 'widgets/slider.dart';
part 'controllers/login_controller.dart';
