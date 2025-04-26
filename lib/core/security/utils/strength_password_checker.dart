

import 'dart:core';

import 'package:injectable/injectable.dart';
import 'package:password_policy/password_policy.dart';
import 'package:validators2/validators2.dart';

@Injectable()
class StrengthPasswordChecker {
  static const List<String> _weakPasswords = [
    "123456",
    "123456789",
    "12345",
    "qwerty",
    "password",
    "12345678",
    "111111",
    "123123",
    "1234567890",
    "1234567",
    "qwerty123",
    "000000",
    "1q2w3e",
    "aa12345678",
    "abc123",
    "password1",
    "1234",
    "qwertyuiop",
    "123321",
    "password123",
  ];

  String? check(
    String password, {
    String? weakPassMsg,
    String? passwordLengthMsg,
    String? passwordUpperCaseMsg,
    String? passwordLowerCaseMsg,
    String? passwordDigitMsg,
    String? passwordNoSpaceMsg,
  }) {
    for (var weak in _weakPasswords) {
      if (equals(password, weak)) {
        return weakPassMsg ?? "Password Is Very Weak";
      }
    }

    PasswordPolicy passwordPolicy = PasswordPolicy(
      minimumScore: 0.6,
      validationRules: [
        LengthRule(
            minimalLength: 6,
            name: passwordLengthMsg ?? "Password should have 6 letter!"),
        UpperCaseRule(
            name: passwordUpperCaseMsg ??
                "Password should have upper case letter!"),
        LowerCaseRule(
            name: passwordLowerCaseMsg ??
                "Password should have lower case letter!"),
        DigitRule(name: passwordDigitMsg ?? "Password should have digits"),
        NoSpaceRule(
            name: passwordNoSpaceMsg ?? "Space is not allowed in password"),
        SpecialCharacterRule(isMandatory: false, name: null),
      ],
    );

    PasswordCheck passwordCheck =
        PasswordCheck(password: password, passwordPolicy: passwordPolicy);
    if (!passwordCheck.isValid) {
      return passwordCheck.notRespectedMandatoryRules
          .map<String?>((rule) => rule.name)
          .join("\n");
    }

    return null;
  }
}
