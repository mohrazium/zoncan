part of zoncan.features.accounts.screen;

class SignupFormValidator = _SignupFormValidator with _$SignupFormValidator;

abstract class _SignupFormValidator with Store, ValidatorMixin {
  @observable
  String? nickNameError;
  @observable
  String? usernameError;
  @observable
  String? emailError;
  @observable
  String? passwordError;
  @observable
  String? confirmPasswordError;

  @computed
  bool get hasError =>
      nickNameError != null ||
      usernameError != null ||
      emailError != null ||
      passwordError != null ||
      confirmPasswordError != null;

  @computed
  bool get isValid =>
      nickNameError == null &&
      usernameError == null &&
      emailError == null &&
      passwordError == null &&
      confirmPasswordError == null;
}

class SignupController extends _SignupController
    with _$SignupController
    implements Controller {
  SignupController(
      super.authService, super.appStateController, super.passwordChecker);

  @override
  void initState() {
    super.setupValidations();
    super.nickNameTextController = TextEditingController();
    super.emailTextController = TextEditingController();
    super.passwordTextController = TextEditingController();
    super.confirmPasswordTextController = TextEditingController();
    logger.info("${this.runtimeType} has been initialized.");
  }

  @override
  void didChangeDependencies() {
    logger.info("${this.runtimeType} dependencies changed.");
  }

  @override
  void dispose() {
    try {
      clearForm();
      super.nickNameTextController?.dispose();
      super.emailTextController?.dispose();
      super.passwordTextController?.dispose();
      super.confirmPasswordTextController?.dispose();
      super.disposeValidations();
      logger.info("${this.runtimeType} disposed.");
    } catch (e) {
      //ignored
    }
  }
}

abstract class _SignupController with Store {
  @protected
  final AuthService authService;
  @protected
  final StrengthPasswordChecker passwordChecker;
  @protected
  final AppStateController appStateController;
  final SignupFormValidator validator = SignupFormValidator();
  TextEditingController? nickNameTextController;
  TextEditingController? emailTextController;
  TextEditingController? passwordTextController;
  TextEditingController? confirmPasswordTextController;

  @observable
  UserDetailsModel userDetails = UserDetailsModel.init();
  @observable
  String nickName = "";
  @observable
  String username = "";
  @observable
  String email = "";
  @observable
  String password = "";
  @observable
  String confirmPassword = "";
  @observable
  ObservableFuture<bool> usernameCheck = ObservableFuture.value(false);
  @observable
  ObservableFuture<bool> emailCheck = ObservableFuture.value(false);
  @protected
  List<ReactionDisposer>? disposers;

  _SignupController(
      this.authService, this.appStateController, this.passwordChecker);

  @computed
  bool get isUsernameCheckPending =>
      usernameCheck.status == FutureStatus.pending;
  @computed
  bool get isEmailCheckPending => emailCheck.status == FutureStatus.pending;
  @computed
  bool get canSignup => !validator.hasError && validator.isValid;

  @action
  void validateNickname(_) {
    validator.nickNameError = null;
    if (isNull(nickName) || nickName.isEmpty) {
      validator.nickNameError = t.validation.notBeEmpty;
    } else if (nickName.length <= 5) {
      validator.nickNameError = t.validation.notValidLength(length: 5);
    } else if (isAlpha(nickName)) {
      validator.nickNameError = t.validation.notValidNickname;
    } else {
      nickName = nickName.trim();
    }
  }

  @action
  Future<void> validateUsername(_) async {
    validator.usernameError = null;
    if (isNull(username) || username.isEmpty) {
      validator.usernameError = t.validation.notBeEmpty;
    } else if (username.length <= 6) {
      validator.usernameError = t.validation.notValidLength(length: 6);
    } else if (!validator.isValidUsername(username)) {
      validator.usernameError = t.validation.notValidUsername;
    } else {
      usernameCheck = ObservableFuture(
          authService.usernameAlreadyExists(username).catchError((error) {
        appStateController.throwException(error);
      }));
      await Future.delayed(const Duration(seconds: 1));
      if (await usernameCheck) {
        validator.usernameError = t.validation.alreadyExistsUsername;
      } else {
        username = username.trim();
      }
    }
  }

  @action
  Future<void> validateEmail(_) async {
    validator.emailError = null;
    if (isNull(email) || email.isEmpty) {
      validator.emailError = t.validation.notBeEmpty;
    } else if (!isEmail(email)) {
      validator.emailError = t.validation.notValidEmail;
    } else {
      emailCheck = ObservableFuture(
          authService.emailAddressAlreadyExists(email).catchError((error) {
        appStateController.throwException(error);
      }));
      await Future.delayed(kDelayWaiting);
      if (await emailCheck) {
        validator.emailError = t.validation.alreadyExistsEmail;
      } else {
        email = email.trim();
      }
    }
  }

  @action
  void validatePassword(_) {
    validator.passwordError = null;
    if (password.isEmpty) {
      validator.passwordError = t.validation.notBeEmpty;
    } else if (password.contains(" ")) {
      validator.passwordError = t.validation.passwordNoSpace;
    } else {
      var passwordErrors = passwordChecker.check(password);
      if (passwordErrors != null) {
        validator.passwordError = passwordErrors;
      } else {
        password = password.trim();
      }
    }
  }

  @action
  void validateConfirmPassword(_) {
    validator.confirmPasswordError = null;
    if (confirmPassword.isEmpty) {
      validator.confirmPasswordError = t.validation.notBeEmpty;
    } else if (!equals(password, confirmPassword)) {
      validator.confirmPasswordError = t.validation.passwordsIsNotMatch;
    } else {
      confirmPassword = confirmPassword.trim();
    }
  }

  @action
  void validateForm() {
    if (nickName.isEmpty) {
      validator.nickNameError = t.validation.notBeEmpty;
    } else if (email.isEmpty) {
      validator.emailError = t.validation.notBeEmpty;
    } else if (password.isEmpty) {
      validator.passwordError = t.validation.notBeEmpty;
    } else if (confirmPassword.isEmpty) {
      validator.confirmPasswordError = t.validation.passwordsIsNotMatch;
    }
  }

  @action
  Future<bool> signup() async {
    validateForm();
    if (canSignup) {
      appStateController.setIsLoading(t.loadingPleaseWait);
      userDetails = UserDetailsModel.init();
      userDetails = userDetails.rebuild(
        (user) => user
          ..nickName = nickName
          ..email = email
          ..userName = email
          ..isActive = true,
      );

      return authService.signup(userDetails, confirmPassword).then((value) {
        if (value != null) {
          userDetails = value;
          appStateController.setCurrentUser(userDetails);
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
      appStateController.throwMessageException(t.login.signupFail);
      return false;
    }
  }

  void setupValidations() {
    disposers = [
      reaction((_) => nickName, validateNickname),
      reaction((_) => username, validateUsername),
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword),
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
    nickNameTextController?.clear();
    emailTextController?.clear();
    passwordTextController?.clear();
    confirmPasswordTextController?.clear();
  }
}
