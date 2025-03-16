part of '../presentation.dart';

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

@Injectable()
class LoginController extends _LoginController
    with _$LoginController
    implements Controller {
  LoginController(
      super.appStateController,
      super.loginUsecase,
      super.emailAddressAlreadyExistsUsecase,
      super.usernameAlreadyExistsUsecase,
      super.rememberedPasswordUsecase,
      super.rememberedUsernameUsecase);

  @override
  Future<void> initState() async {
    super.setupValidations();
    super.usernameController = TextEditingController();
    super.passwordController = TextEditingController();
    final String rememberedUsername = await super
        .rememberedUsernameUsecase
        .call()
        .then((resultValue) => resultValue.fold((error) {
              appStateController.throwException(error);
              return "";
            }, (onResult) => onResult ?? ""));
    final String rememberedPassword = await super
        .rememberedPasswordUsecase
        .call()
        .then((resultValue) => resultValue.fold((error) {
              appStateController.throwException(error);
              return "";
            }, (onResult) => onResult ?? ""));
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
  final LoginUsecase loginUsecase;
  @protected
  final EmailAddressAlreadyExistsUsecase emailAddressAlreadyExistsUsecase;
  @protected
  final UsernameAlreadyExistsUsecase usernameAlreadyExistsUsecase;
  @protected
  final RememberedPasswordUsecase rememberedPasswordUsecase;
  @protected
  final RememberedUsernameUsecase rememberedUsernameUsecase;

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

  _LoginController(
      this.appStateController,
      this.loginUsecase,
      this.emailAddressAlreadyExistsUsecase,
      this.usernameAlreadyExistsUsecase,
      this.rememberedPasswordUsecase,
      this.rememberedUsernameUsecase);

  @computed
  bool get isUsernameAbilityPending =>
      usernameAbility.status == FutureStatus.pending;

  @computed
  bool get canLogin => !validator.hasError && validator.isValid;

  @action
  Future<void> validateUsername(_) async {
    if (isNull(username) || username.isEmpty) {
      validator.usernameError = TranslationsProvider.translator.validation.pleaseEnterUsernameOrEmail;
    } else {
      if (username.length >= 4) {
        if (isEmail(username)) {
          usernameAbility = ObservableFuture(emailAddressAlreadyExistsUsecase
              .call(params: username)
              .then((resultValue) => resultValue.fold((error) {
                    appStateController.throwException(error);
                    return false;
                  }, (onResult) => onResult)));

          await Future.delayed(kDelayWaiting);
          if (await usernameAbility) {
            validator.usernameError = null;
            username = username.trim();
          } else {
            validator.usernameError = TranslationsProvider.translator.validation.emailNotExists;
          }
        } else {
          usernameAbility = ObservableFuture(usernameAlreadyExistsUsecase
              .call(params: username)
              .then((resultValue) => resultValue.fold((error) {
                    appStateController.throwException(error);
                    return false;
                  }, (onResult) => onResult)));

          await Future.delayed(kDelayWaiting);
          if (await usernameAbility) {
            username = username.trim();
            validator.usernameError = null;
          } else {
            validator.usernameError = TranslationsProvider.translator.validation.usernameNotExists;
          }
        }
      }
    }
  }

  @action
  void validatePassword(_) {
    if (isNull(password) || password.isEmpty) {
      validator.passwordError = TranslationsProvider.translator.validation.pleaseEnterPassword;
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
      validator.usernameError = TranslationsProvider.translator.validation.pleaseEnterUsernameOrEmail;
    } else if (password.isEmpty) {
      validator.passwordError = TranslationsProvider.translator.validation.pleaseEnterPassword;
    }
  }

  @action
  Future<void> login() async {
    validateForm();
    appStateController.setIsLoading(TranslationsProvider.translator.loadingPleaseWait);
    if (canLogin) {
      final isLoggedIn = await loginUsecase.call(params: (
        username: username,
        password: password,
        rememberMe: rememberMe
      )).then((value) => value.fold((error) {
            appStateController.unsetIsLoading();
            appStateController.throwException(error);
            return false;
          }, (user) {
            userDetails = user;
            return true;
          }));
      if (isLoggedIn) {
        await Future.delayed(kDelayWaiting).whenComplete(() {
          appStateController.unsetIsLoading();
          clearForm();
          QR.navigator.replaceAll(Routing.to.dashboard.path);
          BotToast.showText(
              text: TranslationsProvider.translator.accounts.loginSuccess, duration: kDelayWaiting);
        }).then((value) async {
          await Future.delayed(kDelayWaiting).whenComplete(() async {
            BotToast.showText(
                text: TranslationsProvider.translator.welcome(
                    fullName: await appStateController.currentUser
                            .then((user) => user?.nickName) ??
                        ""),
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
          appStateController.throwMessageException(TranslationsProvider.translator.accounts.loginFail);
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
