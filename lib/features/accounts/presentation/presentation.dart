library zoncan.features.accounts.persentaion;

import 'dart:math';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:floy/floy.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' as Hooks;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:injectable/injectable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:validators2/validators2.dart';

import 'package:zoncan/app/app.dart' show AppStateController;
import 'package:zoncan/core/common/common.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/config/src/localization/localization.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';
import 'package:zoncan/core/security/security.dart';
import 'package:zoncan/core/utils/utils.dart';

import '../data/data.dart';

part 'pages/accounts_page.dart';
part 'views/accounts_view_large.dart';
part 'widgets/slider.dart';
part 'widgets/login_header.dart';
part 'widgets/password_reset_form.dart';
part 'forms/signup_form.dart';
part 'forms/login_form.dart';
part 'forms/profile_form.dart';
part 'controllers/login_controller.dart';
part 'controllers/profile_controller.dart';
part 'controllers/signup_controller.dart';

part 'presentation.g.dart';

