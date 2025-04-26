
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:validators2/validators2.dart';
import 'package:zoncan/app/app.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';
import 'package:zoncan/core/common/common.dart';
import 'package:zoncan/core/utils/utils.dart';

import '../../data/models/user_details_model.dart';
import '../../domain/usecases/email_address_already_exists_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/remembered_password_usecase.dart';
import '../../domain/usecases/remembered_username_usecase.dart';
import '../../domain/usecases/username_already_exists_usecase.dart';

part 'login_controller.g.dart';

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
    {
  LoginController(
    super.appStateController,
    super.loginUsecase,
    super.emailAddressAlreadyExistsUsecase,
    super.usernameAlreadyExistsUsecase,
    super.rememberedPasswordUsecase,
    super.rememberedUsernameUsecase,
  );

  @override
  Future<void> initState() async {
    super.setupValidations();
    super.usernameController = TextEditingController();
    super.passwordController = TextEditingController();
    final String rememberedUsername = await super.rememberedUsernameUsecase
        .call()
        .then(
          (resultValue) => resultValue.fold((error) {
            showMessage(error);
            return "";
          }, (onResult) => onResult ?? ""),
        );
    final String rememberedPassword = await super.rememberedPasswordUsecase
        .call()
        .then(
          (resultValue) => resultValue.fold((error) {
            showMessage(error);
            return "";
          }, (onResult) => onResult ?? ""),
        );
    super.usernameController?.text = rememberedUsername;
    super.passwordController?.text = rememberedPassword;
    super.username = rememberedUsername;
    super.password = rememberedPassword;
    super.rememberMe =
        rememberedUsername.isNotEmpty && rememberedPassword.isNotEmpty;

    ZLogger(
      logLevel: LogLevel.INFO,
      message: "${this.runtimeType} has been initialized.",
    );
  }

  @override
  void didChangeDependencies() {
    ZLogger(
      logLevel: LogLevel.INFO,
      message: "${this.runtimeType} dependencies changed.",
    );
  }

  @override
  void dispose() {
    try {
      super.disposeValidations();
      clearForm();
      super.usernameController?.dispose();
      super.passwordController?.dispose();
      ZLogger(
        logLevel: LogLevel.INFO,
        message: "${this.runtimeType} disposed.",
      );
    } catch (e) {
      //ignored
    }
    return;
  }
}

abstract class _LoginController extends Controller with Store {
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

  @observable
  bool isLoading = false;
  @observable
  String? loadingText;
  @observable
  String? successMessage;
  @observable
  FailureException? exception;
  @computed
  bool get errorHappened => exception != null && exception!.hasError;

  @action
  void setIsLoading([String? msg]) {
    loadingText = msg;
    isLoading = true;
  }

  @action
  void unsetIsLoading() {
    loadingText = null;
    isLoading = false;
  }

  @action
  void showMessage(dynamic error) {
    if (error is FailureException) {
      exception = error;
    } else if (error is String) {
      exception = FailureException(userMessage: error);
    } else {
      exception = null;
    }
  }

  _LoginController(
    this.appStateController,
    this.loginUsecase,
    this.emailAddressAlreadyExistsUsecase,
    this.usernameAlreadyExistsUsecase,
    this.rememberedPasswordUsecase,
    this.rememberedUsernameUsecase,
  );

  @computed
  bool get isUsernameAbilityPending =>
      usernameAbility.status == FutureStatus.pending;

  @computed
  bool get canLogin => !validator.hasError && validator.isValid;

  @action
  Future<void> validateUsername(u) async {
    if (isNull(username) || username.isEmpty) {
      validator.usernameError =
          TranslationsProvider.translator.validation.pleaseEnterUsernameOrEmail;
    } else {
      if (username.length >= 4) {
        if (isEmail(username)) {
          usernameAbility = ObservableFuture(
            emailAddressAlreadyExistsUsecase
                .call(params: username)
                .then(
                  (resultValue) => resultValue.fold((error) {
                    showMessage(error);
                    return false;
                  }, (onResult) => onResult),
                ),
          );

          await Future.delayed(kDelayWaiting);
          if (await usernameAbility) {
            validator.usernameError = null;
            username = username.trim();
          } else {
            validator.usernameError =
                TranslationsProvider.translator.validation.emailNotExists;
          }
        } else {
          usernameAbility = ObservableFuture(
            usernameAlreadyExistsUsecase
                .call(params: username)
                .then(
                  (resultValue) => resultValue.fold((error) {
                    showMessage(error);
                    return false;
                  }, (onResult) => onResult),
                ),
          );

          await Future.delayed(kDelayWaiting);
          if (await usernameAbility) {
            username = username.trim();
            validator.usernameError = null;
          } else {
            validator.usernameError =
                TranslationsProvider.translator.validation.usernameNotExists;
          }
        }
      }
    }
  }

  @action
  void validatePassword(p) {
    if (isNull(password) || password.isEmpty) {
      validator.passwordError =
          TranslationsProvider.translator.validation.pleaseEnterPassword;
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
      validator.usernameError =
          TranslationsProvider.translator.validation.pleaseEnterUsernameOrEmail;
    } else if (password.isEmpty) {
      validator.passwordError =
          TranslationsProvider.translator.validation.pleaseEnterPassword;
    }
  }

  @action
  Future<void> login() async {
    validateForm();
    setIsLoading(
      TranslationsProvider.translator.loadingPleaseWait,
    );
    if (canLogin) {
      final isLoggedIn = await loginUsecase
          .call(
            params: (
              username: username,
              password: password,
              rememberMe: rememberMe,
            ),
          )
          .then(
            (value) => value.fold(
              (error) {
                unsetIsLoading();
                showMessage(error);
                return false;
              },
              (user) {
                userDetails = user;
                return true;
              },
            ),
          );
      if (isLoggedIn) {
        await Future.delayed(kDelayWaiting)
            .whenComplete(() {
              unsetIsLoading();
              clearForm();
              QR.navigator.replaceAll(Routing.to.dashboard.path);
              BotToast.showText(
                text: TranslationsProvider.translator.accounts.loginSuccess,
                duration: kDelayWaiting,
              );
            })
            .then((value) async {
              await Future.delayed(kDelayWaiting).whenComplete(() async {
                BotToast.showText(
                  text: TranslationsProvider.translator.welcome(
                    fullName:
                        await appStateController.currentUser.then(
                          (user) => user?.nickName,
                        ) ??
                        "",
                  ),
                  duration: kDelayWaiting,
                );
              });
            });
      }
    } else {
      await Future.delayed(kDelayWaiting).whenComplete(() {
        unsetIsLoading();
        if (validator.usernameError != null) {
          showMessage(validator.usernameError!);
        } else if (validator.passwordError != null) {
          showMessage(validator.passwordError!);
        } else {
          showMessage(
            TranslationsProvider.translator.accounts.loginFail,
          );
        }
      });
    }
  }


  void setupValidations() {
    disposers = [
      reaction((u) => username, validateUsername),
      reaction((p) => password, validatePassword),
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
