part of '../presentation.dart';

@Injectable()
class HomeController extends _HomeController
    with _$HomeController
    implements Controller {
  HomeController(super.authService, super.appStateController);

  @override
  Future<void> initState() async {
    logger.info("${this.runtimeType} has been initialized.");
  }

  @override
  void didChangeDependencies() {
    logger.info("${this.runtimeType} dependencies changed.");
  }

  @override
  void dispose() {
    try {
      logger.info("${this.runtimeType} disposed.");
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
    return user?.isCompletedFirstSetup ?? false;
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
