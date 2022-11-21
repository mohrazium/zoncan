part of zoncan.security;

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

  String? check(String password) {
    for (var weak in _weakPasswords) {
      if (equals(password, weak)) {
        return t.validation.passwordIsVeryWeak;
      }
    }

    PasswordPolicy passwordPolicy = PasswordPolicy(
      minimumScore: 0.6,
      validationRules: [
        LengthRule(minimalLength: 6, name: t.validation.passwordLength),
        UpperCaseRule(name: t.validation.passwordUpperCase),
        LowerCaseRule(name: t.validation.passwordLowerCase),
        DigitRule(name: t.validation.passwordDigit),
        NoSpaceRule(name: t.validation.passwordNoSpace),
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
