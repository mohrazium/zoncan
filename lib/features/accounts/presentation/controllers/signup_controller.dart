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
    super.appStateController,
  );

  @override
  void initState() {
    super.setupValidations();
    super.nickNameTextController = TextEditingController();
    super.emailTextController = TextEditingController();
    super.passwordTextController = TextEditingController();
    super.confirmPasswordTextController = TextEditingController();
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
      clearForm();
      super.nickNameTextController?.dispose();
      super.emailTextController?.dispose();
      super.passwordTextController?.dispose();
      super.confirmPasswordTextController?.dispose();
      super.disposeValidations();
      ZLogger(
        logLevel: LogLevel.INFO,
        message: "${this.runtimeType} disposed.",
      );
    } catch (e) {
      //ignored
    }
  }
}

abstract class _SignupController extends Controller with Store {
  @protected
  final SignUpUsecase signUpUsecase;
  @protected
  final UsernameAlreadyExistsUsecase usernameAlreadyExistsUsecase;
  @protected
  final EmailAddressAlreadyExistsUsecase emailAddressAlreadyExistsUsecase;
  @protected
  final StrengthPasswordChecker passwordChecker;

  @observable
  UsecaseExecutor<bool> signUpState = UsecaseExecutor<bool>();

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
  @observable
  FailureException? exception;

  @protected
  List<ReactionDisposer>? disposers;

  _SignupController(
    this.signUpUsecase,
    this.usernameAlreadyExistsUsecase,
    this.emailAddressAlreadyExistsUsecase,
    this.passwordChecker,
    this.appStateController,
  );

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
      validator.nickNameError = TranslationsProvider.translator.validation
          .notValidLength(length: 5);
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
      validator.usernameError = TranslationsProvider.translator.validation
          .notValidLength(length: 6);
    } else if (!validator.isValidUsername(username)) {
      validator.usernameError =
          TranslationsProvider.translator.validation.notValidUsername;
    } else {
      usernameCheck = ObservableFuture(
        usernameAlreadyExistsUsecase
            .call(params: username)
            .then(
              (resultValue) => resultValue.fold((error) {
                exception = error;
                return false;
              }, (onResult) => onResult),
            ),
      );
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
      emailCheck = ObservableFuture(
        emailAddressAlreadyExistsUsecase
            .call(params: email)
            .then(
              (resultValue) => resultValue.fold((error) {
                exception = error;
                return false;
              }, (onResult) => onResult),
            ),
      );
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
      var passwordErrors = passwordChecker.check(
        weakPassMsg:
            TranslationsProvider.translator.validation.passwordIsVeryWeak,
        passwordDigitMsg:
            TranslationsProvider.translator.validation.passwordDigit,
        passwordLengthMsg:
            TranslationsProvider.translator.validation.passwordLength,
        passwordLowerCaseMsg:
            TranslationsProvider.translator.validation.passwordLowerCase,
        passwordNoSpaceMsg:
            TranslationsProvider.translator.validation.passwordNoSpace,
        passwordUpperCaseMsg:
            TranslationsProvider.translator.validation.passwordUpperCase,
        password,
      );
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
    validateForm(); // Ensure form is validated before attemping to signup
    // Check validation state before starting the signup proccess
    if (canSignup) {
      userDetails = UserDetailsModel.init(); // init new user details
      // coping new value from form to new user details
      userDetails = userDetails.copyWith(
        nickName: nickName,
        email: email,
        userName: username.isNotEmpty ? username : email,
        isActive: true,
      );
      await signUpState.execute(
        () => signUpUsecase
            .call(params: (user: userDetails, password: confirmPassword))
            .then(
              (resultValue) => resultValue.fold(
                // Error case: Let executeUseCase handle the error state.
                // We just need to throw the FailureException so executeUseCase catches it.
                (error) => throw error,
                //Success case : return the true value
                (onResult) {
                  if (onResult != null) {
                    userDetails = onResult;
                    return true;
                  } else {
                    return false;
                  }
                },
              ),
            ),
      );
      if (signUpState.data != null) {
        clearForm(); // Clear form values
        // Navigate to dashboard
        QR.navigator.replaceAll(Routing.to.dashboard.path);
      }
    } else {
      await Future.delayed(kDelayWaiting).whenComplete(() {
        if (validator.nickNameError != null) {
          exception = FailureException(userMessage: validator.nickNameError!);
        } else if (validator.usernameError != null) {
          exception = FailureException(userMessage: validator.usernameError!);
        } else if (validator.passwordError != null) {
          exception = FailureException(userMessage: validator.passwordError!);
        } else if (validator.confirmPasswordError != null) {
          exception = FailureException(
            userMessage: validator.confirmPasswordError!,
          );
        } else {
          exception = FailureException(
            userMessage: TranslationsProvider.translator.accounts.signupFail,
          );
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
