import 'package:flutter/widgets.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/app/app.dart';
import 'package:zoncan/config/config.dart';

class WizardMiddleware extends QMiddleware {
  @override
  Future<String?> redirectGuard(String path) async {
    final appStateController = Injection.serviceLocator<AppStateController>();
    final userDetails = appStateController.currentUser;
    debugPrint("userDetails.toString()");
    debugPrint(userDetails.toString());
    if (userDetails != null) {
      if (userDetails.isCompletedFirstSetup == null ||
          !userDetails.isCompletedFirstSetup!) {
        return Routing.to.wizardStepVerifyPhonenumber.path;
      } else {
        return Routing.to.dashboard.path;
      }
    } else {
      return null;
    }
  }
}
