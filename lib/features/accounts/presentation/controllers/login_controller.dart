part of zoncan.features.accounts.presentation;

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
  void initState() {
    super.usernameController = TextEditingController();
    super.passwordController = TextEditingController();
    super.setupValidations();
    logger.info("${this.runtimeType} has been initialized.");
  }

  @override
  void didChangeDependencies() {
    logger.info("${this.runtimeType} dependencies changed.");
  }

  @override
  void dispose() {
    super.disposeValidations();
    super.usernameController.dispose();
    super.passwordController.dispose();
    logger.info("${this.runtimeType} disposed.");
  }
}

abstract class _LoginController with Store {
  @protected
  final AuthService authService;
  @protected
  final AppStateController appStateController;
  final LoginFormValidator validator = LoginFormValidator();

  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  @protected
  late List<ReactionDisposer> disposers;
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
      validator.usernameError = t.validation.notBeEmpty;
    } else if (password.isEmpty) {
      validator.passwordError = t.validation.notBeEmpty;
    }
  }

  @action
  Future<bool> login() async {
    authService.login(username, password);

    validateForm();
    if (canLogin) {
      appStateController.setIsLoading(t.loadingPleaseWait);
      return await authService.login(username, password).then((value) {
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
      }).whenComplete(() {
        appStateController.unsetIsLoading();
      });
    } else {
      appStateController.throwMessageException(t.login.loginFail);
      return false;
    }
  }

  void setupValidations() {
    disposers = [
      reaction((_) => username, validateUsername),
      reaction((_) => password, validatePassword),
    ];
  }

  void disposeValidations() {
    for (var dispose in disposers) {
      dispose();
    }
  }

  void clearForm() {
    usernameController.clear();
    passwordController.clear();
  }
}
