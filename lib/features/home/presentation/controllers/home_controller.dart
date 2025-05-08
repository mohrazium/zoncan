import 'package:floy/floy.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:zoncan/app/src/app_state_controller.dart';
import 'package:zoncan/config/config.dart'
    show TranslationsProvider, kDelayWaiting;
import 'package:zoncan/core/common/common.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';
import 'package:zoncan/core/security/domain/repository/authentication_repository.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController extends _HomeController with _$HomeController {
  HomeController(super.authService, super.appStateController);

  @override
  Future<void> initState() async {
    ZLogger(
      logLevel: LogLevel.INFO,
      message: "${this.runtimeType} has been initialized.",
    );
  }

  @override
  void didChangeDependencies() {
    Future.microtask(() async {
      await appStateController.didChangeDependencies();
    });
    ZLogger(
      logLevel: LogLevel.INFO,
      message: "${this.runtimeType} dependencies changed.",
    );
  }

  @override
  void dispose() {
    try {
      ZLogger(
        logLevel: LogLevel.INFO,
        message: "${this.runtimeType} disposed.",
      );
    } catch (e) {
      //ignored
    }
  }
}

abstract class _HomeController extends Controller with Store {
  @protected
  final AuthenticationRepository authService;

  final AppStateController appStateController;

  @observable
  UsecaseExecutor<bool?> logoutState = UsecaseExecutor<bool?>();

  @observable
  FailureException? exception;

  @computed
  bool get isCompletedFirstSetup {
    final user = appStateController.currentUser;
    return user != null ? user.isCompletedFirstSetup ?? false : false;
  }

  _HomeController(this.authService, this.appStateController);

  @action
  Future<bool?> logoutUser() async {
    await logoutState.execute(
      () => authService.logout().then(
        (isLoggedOut) => isLoggedOut.fold(
          (failure) {
            return false;
          },
          (loggedOut) {
            return true;
          },
        ),
      ),
    );
    if (logoutState.data != null) {
      return logoutState.data;
    } else {
      exception = FailureException(
        userMessage: TranslationsProvider.translator.accounts.logoutFailed,
      );
      return false;
    }
  }

  @action
  Future<void> loadSetupPage(
    BuildContext context,
    AsyncSnapshot snapshot,
  ) async {
    if (snapshot.hasData) {
      if (snapshot.data != null && !snapshot.data!) {
        //!TODO :  Fix setup page call
        await Future.delayed(kDelayWaiting).whenComplete(() {
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
}
