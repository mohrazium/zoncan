
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
import 'package:zoncan/core/security/security.dart';
import 'package:zoncan/core/utils/utils.dart';

import '../../data/models/user_details_model.dart';
import '../../domain/usecases/email_address_already_exists_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/username_already_exists_usecase.dart';

part 'signup_controller.g.dart';

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

@Injectable()
class SignupController extends _SignupController
    with _$SignupController
    implements Controller {
  SignupController(
      super.signUpUsecase,
      super.usernameAlreadyExistsUsecase,
      super.emailAddressAlreadyExistsUsecase,
      super.passwordChecker,
      super.appStateController);

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
  final SignUpUsecase signUpUsecase;
  @protected
  final UsernameAlreadyExistsUsecase usernameAlreadyExistsUsecase;
  @protected
  final EmailAddressAlreadyExistsUsecase emailAddressAlreadyExistsUsecase;
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
      this.signUpUsecase,
      this.usernameAlreadyExistsUsecase,
      this.emailAddressAlreadyExistsUsecase,
      this.passwordChecker,
      this.appStateController);

  @computed
  bool get isUsernameCheckPending =>
      usernameCheck.status == FutureStatus.pending;

  @computed
  bool get isEmailCheckPending => emailCheck.status == FutureStatus.pending;

  @computed
  bool get canSignup => !validator.hasError && validator.isValid;

  @action
  void validateNickname(n) {
    validator.nickNameError = null;
    if (isNull(nickName) || nickName.isEmpty) {
      validator.nickNameError =
          TranslationsProvider.translator.validation.notBeEmpty;
    } else if (nickName.length <= 5) {
      validator.nickNameError =
          TranslationsProvider.translator.validation.notValidLength(length: 5);
    } else if (isAlpha(nickName)) {
      validator.nickNameError =
          TranslationsProvider.translator.validation.notValidNickname;
    } else {
      nickName = nickName.trim();
    }
  }

  @action
  Future<void> validateUsername(u) async {
    validator.usernameError = null;
    if (isNull(username) || username.isEmpty) {
      validator.usernameError =
          TranslationsProvider.translator.validation.notBeEmpty;
    } else if (username.length <= 6) {
      validator.usernameError =
          TranslationsProvider.translator.validation.notValidLength(length: 6);
    } else if (!validator.isValidUsername(username)) {
      validator.usernameError =
          TranslationsProvider.translator.validation.notValidUsername;
    } else {
      usernameCheck = ObservableFuture(usernameAlreadyExistsUsecase
          .call(params: username)
          .then((resultValue) => resultValue.fold((error) {
                appStateController.showMessage(error);
                return false;
              }, (onResult) => onResult)));
      await Future.delayed(const Duration(seconds: 1));
      if (await usernameCheck) {
        validator.usernameError =
            TranslationsProvider.translator.validation.alreadyExistsUsername;
      } else {
        username = username.trim();
      }
    }
  }

  @action
  Future<void> validateEmail(e) async {
    validator.emailError = null;
    if (isNull(email) || email.isEmpty) {
      validator.emailError =
          TranslationsProvider.translator.validation.notBeEmpty;
    } else if (!isEmail(email)) {
      validator.emailError =
          TranslationsProvider.translator.validation.notValidEmail;
    } else {
      emailCheck = ObservableFuture(emailAddressAlreadyExistsUsecase
          .call(params: email)
          .then((resultValue) => resultValue.fold((error) {
                appStateController.showMessage(error);
                return false;
              }, (onResult) => onResult)));
      await Future.delayed(kDelayWaiting);
      if (await emailCheck) {
        validator.emailError =
            TranslationsProvider.translator.validation.alreadyExistsEmail;
      } else {
        email = email.trim();
      }
    }
  }

  @action
  void validatePassword(p) {
    validator.passwordError = null;
    if (password.isEmpty) {
      validator.passwordError =
          TranslationsProvider.translator.validation.notBeEmpty;
    } else if (password.contains(" ")) {
      validator.passwordError =
          TranslationsProvider.translator.validation.passwordNoSpace;
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
  void validateConfirmPassword(cp) {
    validator.confirmPasswordError = null;
    if (confirmPassword.isEmpty) {
      validator.confirmPasswordError =
          TranslationsProvider.translator.validation.notBeEmpty;
    } else if (!equals(password, confirmPassword)) {
      validator.confirmPasswordError =
          TranslationsProvider.translator.validation.passwordsIsNotMatch;
    } else {
      confirmPassword = confirmPassword.trim();
    }
  }

  @action
  void validateForm() {
    if (nickName.isEmpty) {
      validator.nickNameError =
          TranslationsProvider.translator.validation.notBeEmpty;
    } else if (email.isEmpty) {
      validator.emailError =
          TranslationsProvider.translator.validation.notBeEmpty;
    } else if (password.isEmpty) {
      validator.passwordError =
          TranslationsProvider.translator.validation.notBeEmpty;
    } else if (confirmPassword.isEmpty) {
      validator.confirmPasswordError =
          TranslationsProvider.translator.validation.passwordsIsNotMatch;
    }
  }

  @action
  Future<void> signup() async {
    validateForm();
    appStateController
        .setIsLoading(TranslationsProvider.translator.loadingPleaseWait);
    if (canSignup) {
      userDetails = UserDetailsModel.init();
      userDetails = userDetails.copyWith(
        nickName: nickName,
        email: email,
        userName: username.isNotEmpty ? username : email,
        isActive: true,
      );
      final isSignedUp = await signUpUsecase.call(params: (
        user: userDetails,
        password: confirmPassword,
      )).then((resultValue) => resultValue.fold((error) {
            appStateController.unsetIsLoading();
            appStateController.showMessage(error);
            return false;
          }, (onResult) {
            if (onResult != null) {
              userDetails = onResult;
              return true;
            } else {
              return false;
            }
          }));

      if (isSignedUp) {
        await Future.delayed(kDelayWaiting).whenComplete(() {
          appStateController.unsetIsLoading();
          clearForm();
          QR.navigator.replaceAll(Routing.to.dashboard.path);

          BotToast.showText(
              text: TranslationsProvider.translator.accounts.signupSuccess,
              duration: kDelayWaiting);
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
        if (validator.nickNameError != null) {
          appStateController.showMessage(validator.nickNameError!);
        } else if (validator.usernameError != null) {
          appStateController.showMessage(validator.usernameError!);
        } else if (validator.passwordError != null) {
          appStateController.showMessage(validator.passwordError!);
        } else if (validator.confirmPasswordError != null) {
          appStateController
              .showMessage(validator.confirmPasswordError!);
        } else {
          appStateController.showMessage(
              TranslationsProvider.translator.accounts.signupFail);
        }
      });
    }
  }

  void setupValidations() {
    disposers = [
      reaction((n) => nickName, validateNickname),
      reaction((u) => username, validateUsername),
      reaction((e) => email, validateEmail),
      reaction((p) => password, validatePassword),
      reaction((cp) => confirmPassword, validateConfirmPassword),
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
