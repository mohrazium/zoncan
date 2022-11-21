part of zoncan.app;

class AppStateController extends _AppStateControllerStore
    with _$AppStateController {
  @override
  void didChangeDependencies() {
    logger.info("${this.runtimeType} changed dependencies.");
  }

  @override
  void dispose() {
    logger.info("${this.runtimeType} disposed.");
  }

  @override
  void initState() {
    logger.info("${this.runtimeType} init state.");
  }
}

abstract class _AppStateControllerStore extends Controller with Store {
  @observable
  ThemeMode themeMode = ThemeMode.light;
  @observable
  bool isLoading = false;
  @observable
  String loadingText = "";
  @observable
  FailureException? exception;
  @observable
  UserDetailsModel? currentUser;

  @computed
  bool get errorHappened => exception != null && exception!.hasError;

  @action
  void setIsLoading(String? msg) {
    loadingText = msg ?? "";
    isLoading = true;
  }

  @action
  void unsetIsLoading() {
    loadingText = "";
    isLoading = false;
  }

  @action
  void switchTheme([ThemeMode? mode]) {
    themeMode = mode ??
        (themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  @action
  void throwMessageException(String message) {
    exception = FailureException(message: message);
  }

  @action
  void throwException(FailureException? exp) {
    exception = exp;
  }

  @action
  void setCurrentUser(UserDetailsModel user) {
    currentUser = user;
  }
}
