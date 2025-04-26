
import 'package:floy/floy.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/app/src/app_state_controller.dart';
import 'package:zoncan/config/src/constants/app_constants.dart';
import 'package:zoncan/config/src/localization/localization.dart';
import 'package:zoncan/config/src/router/routes.dart';
import 'package:zoncan/core/common/generics/controller.dart';
import 'package:zoncan/core/exceptions/failure_exception.dart';
import 'package:zoncan/core/exceptions/log_level.dart';
import 'package:zoncan/core/security/domain/repository/authentication_repository.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController extends _HomeController
    with _$HomeController
    implements Controller {
  HomeController(super.authService, super.appStateController);

  @override
  Future<void> initState() async {
   ZLogger(
      logLevel: LogLevel.INFO,message: "${this.runtimeType} has been initialized.");
  }

  @override
  void didChangeDependencies() {
     ZLogger(
      logLevel: LogLevel.INFO,message:"${this.runtimeType} dependencies changed.");
  }

  @override
  void dispose() {
    try {
       ZLogger(
      logLevel: LogLevel.INFO,message:"${this.runtimeType} disposed.");
    } catch (e) {
      //ignored
    }
  }
}

abstract class _HomeController with Store {
  @protected
  final AuthenticationRepository authService;
  @protected
  final AppStateController appStateController;

  @computed
  Future<bool> get isCompletedFirstSetup async {
    final user = await appStateController.currentUser;
    return user == null ? false : user.isCompletedFirstSetup ?? false;
  }

  @computed
  Future<String?> get currentUserNickName async =>
      await appStateController.currentUser.then((user) => user!.nickName);

  @action
  Future<bool?> logoutUser() async {
    appStateController
        .setIsLoading(TranslationsProvider.translator.loadingPleaseWait);
    return await authService
        .logout()
        .then((isLoggedOut) => isLoggedOut.fold((failure) {
              appStateController.showMessage(failure.userMessage ?? "");
              return false;
            }, (loggedOut) {
              appStateController.unsetIsLoading();
              QR.navigator.replaceAll(Routing.to.login.path);
              return true;
            }));
  }

  @action
  Future<void> loadSetupPage(
      BuildContext context, AsyncSnapshot snapshot) async {
    appStateController
        .setIsLoading(TranslationsProvider.translator.loadingPleaseWait);
    if (snapshot.hasData) {
      if (snapshot.data != null && !snapshot.data!) {
        //!TODO :  Fix setup page call
        await Future.delayed(kDelayWaiting).whenComplete(() {
          appStateController.unsetIsLoading();
          if (Floy.isDesktop()) {
            print("in home controller is desktop section");
          } else {
            print("in home controller is not desktop section");
          }
        });
      }
    } else if (snapshot.hasError) {
      print("in home controller snapshot with error");
    }
  }

  _HomeController(this.authService, this.appStateController);
}
