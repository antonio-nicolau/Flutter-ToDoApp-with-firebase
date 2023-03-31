class InputValidator {
  InputValidator();

  final _emailRegex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9|-]+\.[a-zA-Z]+";
  final _passwordRegex = r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*^[^~*?%<>]*$).{6,32}$";

  String? validate({
    String? email,
    String? password,
  }) {
    if (email != null && !isEmailValid(email)) {
      return 'Introduce a valid email';
    } else if (password != null && !isPasswordValid(password)) {
      return 'Introduce a valid password';
    }
    return null;
  }

  String? validatePassword({
    String? password,
    String? passwordToMatch,
  }) {
    if (!isPasswordValid(password)) {
      return 'Password must contains at least 6 letters';
    }

    return null;
  }

  bool isPasswordValid(String? password) {
    return RegExp(_passwordRegex).hasMatch(password.toString());
  }

  bool? isEmpty(String? value) => value?.trim().isEmpty;

  bool isEmailValid(String? email) {
    return RegExp(_emailRegex).hasMatch(email.toString());
  }
}
