class Validator {
  static bool validateEmail(emailValue) {
    final emailsRegEX =
        RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,3})$');
    return emailsRegEX.hasMatch(emailValue);
  }

  static bool validatePasswored(passwordValue) {
    final passwordRegEx = RegExp(
        r'(?=^.{6,}$)((?=.*\w)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[|!"$%&\/\(\)\?\^\+\@\-\*]))^.*');
    return passwordRegEx.hasMatch(passwordValue);
  }

  static bool validateUsername(userValue) {
    final usernameRegEx = RegExp(r'^[a-z0-9_@-]{3,16}$');
    return usernameRegEx.hasMatch(userValue);
  }

  static bool validatePhone(phoneValue) {
    final phoneRegEx = RegExp(r'(?=^98\d{8}$)');
    return phoneRegEx.hasMatch(phoneValue);
  }
}
