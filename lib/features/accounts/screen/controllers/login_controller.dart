part of zoncan.features.accounts.screen;

class LoginFormValidator = _LoginFormValidator with _$LoginFormValidator;

abstract class _LoginFormValidator with Store, ValidatorMixin {
  @observable
  String? usernameError;
  @observable
  String? passwordError;

  @computed
  bool get hasError => usernameError != null || passwordError != null;
  @computed
  bool get isValid => usernameError == null && passwordError == null;
}

class LoginController extends _LoginController
    with _$LoginController
    implements Controller {
  LoginController(super.authService, super.appStateController);

  @override
  Future<void> initState() async {
    super.setupValidations();
    super.usernameController = TextEditingController();
    super.passwordController = TextEditingController();
    final String rememberedUsername =
        await super.authService.rememberedUsername ?? "";
    final String rememberedPassword =
        await super.authService.rememberedPassword ?? "";
    super.usernameController?.text = rememberedUsername;
    super.passwordController?.text = rememberedPassword;
    super.username = rememberedUsername;
    super.password = rememberedPassword;
    super.rememberMe =
        rememberedUsername.isNotEmpty && rememberedPassword.isNotEmpty;

    logger.info("${this.runtimeType} has been initialized.");
  }

  @override
  void didChangeDependencies() {
    logger.info("${this.runtimeType} dependencies changed.");
  }

  @override
  void dispose() {
    try {
      super.disposeValidations();
      clearForm();
      super.usernameController?.dispose();
      super.passwordController?.dispose();
      logger.info("${this.runtimeType} disposed.");
    } catch (e) {
      //ignored
    }
  }
}

abstract class _LoginController with Store {
  @protected
  final AuthService authService;
  @protected
  final AppStateController appStateController;
  final LoginFormValidator validator = LoginFormValidator();

  TextEditingController? usernameController;
  TextEditingController? passwordController;
  @protected
  List<ReactionDisposer>? disposers;
  @observable
  UserDetailsModel? userDetails;
  @observable
  String username = "";
  @observable
  String password = "";
  @observable
  bool rememberMe = false;
  @observable
  ObservableFuture<bool> usernameAbility = ObservableFuture.value(false);

  _LoginController(this.authService, this.appStateController);

  @computed
  bool get isUsernameAbilityPending =>
      usernameAbility.status == FutureStatus.pending;
  @computed
  bool get canLogin => !validator.hasError && validator.isValid;

  @action
  Future<void> validateUsername(_) async {
    if (isNull(username) || username.isEmpty) {
      validator.usernameError = t.validation.pleaseEnterUsernameOrEmail;
    } else {
      if (username.length >= 4) {
        if (isEmail(username)) {
          usernameAbility = ObservableFuture(authService
              .emailAddressAlreadyExists(username)
              .catchError((error) {
            appStateController.throwException(error);
          }));
          await Future.delayed(kDelayWaiting);
          if (await usernameAbility) {
            validator.usernameError = null;
            username = username.trim();
          } else {
            validator.usernameError = t.validation.emailNotExists;
          }
        } else {
          usernameAbility = ObservableFuture(
              authService.usernameAlreadyExists(username).catchError((error) {
            appStateController.throwException(error);
          }));
          await Future.delayed(kDelayWaiting);
          if (await usernameAbility) {
            username = username.trim();
            validator.usernameError = null;
          } else {
            validator.usernameError = t.validation.usernameNotExists;
          }
        }
      }
    }
  }

  @action
  void validatePassword(_) {
    if (isNull(password) || password.isEmpty) {
      validator.passwordError = t.validation.pleaseEnterPassword;
    } else {
      validator.passwordError = null;
      password = password.trim();
    }
  }

  @action
  void changeRememberMe(bool val) => rememberMe = val;

  @action
  void validateForm() {
    if (username.isEmpty) {
      validator.usernameError = t.validation.pleaseEnterUsernameOrEmail;
    } else if (password.isEmpty) {
      validator.passwordError = t.validation.pleaseEnterPassword;
    }
  }

  @action
  Future<void> login() async {
    validateForm();
    appStateController.setIsLoading(t.loadingPleaseWait);
    if (canLogin) {
      final isLoggedIn =
          await authService.login(username, password, rememberMe).then((value) {
        if (value != null) {
          userDetails = value;
          appStateController.setCurrentUser(userDetails!);
          clearForm();
          return true;
        } else {
          return false;
        }
      }).catchError((error) {
        appStateController.unsetIsLoading();
        appStateController.throwException(error);
        return false;
      });
      if (isLoggedIn) {
        await Future.delayed(kDelayWaiting).whenComplete(() {
          appStateController.unsetIsLoading();
          Modular.to.navigate(Routing.to.home.path);
          BotToast.showText(
              text: t.login.loginSuccess, duration: kDelayWaiting);
        }).then((value) async {
          await Future.delayed(kDelayWaiting).whenComplete(() {
            BotToast.showText(
                text: t.welcome(
                    fullName: appStateController.currentUser?.nickName ?? ""),
                duration: kDelayWaiting);
          });
        });
      }
    } else {
      await Future.delayed(kDelayWaiting).whenComplete(() {
        appStateController.unsetIsLoading();
        if (validator.usernameError != null) {
          appStateController.throwMessageException(validator.usernameError!);
        } else if (validator.passwordError != null) {
          appStateController.throwMessageException(validator.passwordError!);
        } else {
          appStateController.throwMessageException(t.login.loginFail);
        }
      });
    }
  }

  void setupValidations() {
    disposers = [
      reaction((_) => username, validateUsername),
      reaction((_) => password, validatePassword),
    ];
  }

  void disposeValidations() {
    if (disposers != null) {
      for (var dispose in disposers!) {
        dispose();
      }
    }
  }

  void clearForm() {
    usernameController?.clear();
    passwordController?.clear();
  }
}
