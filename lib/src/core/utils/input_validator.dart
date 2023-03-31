import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputValidator {
  final BuildContext _buildContext;
  InputValidator(this._buildContext);

  final _emailRegex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9|-]+\.[a-zA-Z]+";
  final _passwordRegex = r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*^[^~*?%<>]*$).{6,32}$";

  String? validate({
    String? email,
    String? password,
  }) {
    if (email != null && !isEmailValid(email)) {
      return AppLocalizations.of(_buildContext)!.error_invalid_email;
    } else if (password != null && !isPasswordValid(password)) {
      return AppLocalizations.of(_buildContext)!.error_invalid_password;
    }
    return null;
  }

  bool isPasswordValid(String? password) {
    return RegExp(_passwordRegex).hasMatch(password.toString());
  }

  bool isEmailValid(String? email) {
    return RegExp(_emailRegex).hasMatch(email.toString());
  }
}
