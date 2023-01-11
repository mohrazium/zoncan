part of zoncan.app;

class AppStateController extends _AppStateControllerStore
    with _$AppStateController {
  AppStateController(super.settingsProvider);

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
    loadAllSettings();
    logger.info("${this.runtimeType} init state.");
  }
}

abstract class _AppStateControllerStore extends Controller with Store {
  final SettingsProvider settingsProvider;

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
  @observable
  SettingProperties settings = SettingProperties.init();
  @observable
  bool shouldRefreshUI = false;

  _AppStateControllerStore(this.settingsProvider);

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

  @action
  Future<void> loadAllSettings() async {
    shouldRefreshUI = false;
    settings = await settingsProvider.loadSettings();
  }

  @action
  Future<void> saveFontScale(double scale) async {
    settings = await settingsProvider.saveFontScaleFactor(scale);
    shouldRefreshUI = true;
  }
}
