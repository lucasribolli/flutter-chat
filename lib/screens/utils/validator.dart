mixin ValidatorMixin {
  String? _warningMessage;

  String? get warningMessage {
    return _warningMessage;
  }
}

abstract class FieldValidator with ValidatorMixin {
  bool isValid();
}

class NameValidator extends FieldValidator {
  late String _name;

  NameValidator(String? name) {
    _name = name ?? '';
  }

  @override
  bool isValid() {
    if(_isSmallThanFiveDigits()) {
      _warningMessage = 'Name needs to be bigger than 5 digits.';
      return false;
    }
    return true;
  }

  bool _isSmallThanFiveDigits() {
    return _name.trim().length < 5;
  }
}

class EmailValidator extends FieldValidator {
  late String _email;

  EmailValidator(String? email) {
    _email = email ?? '';
  }

  @override
  bool isValid() {
    if(!_isAccordingRegex()) {
      _warningMessage = 'Digit a valid email.';
      return false;
    }
    return true;
  }

  bool _isAccordingRegex() {
    return _email.contains(RegExp(r'\w+@\w+.\w+'));
  }
}

class PasswordValidator extends FieldValidator {
  late String _password;

  PasswordValidator(String? password) {
    _password = password ?? '';
  }

  @override
  bool isValid() {
    if(_isSmallThanSixDigits()) {
      _warningMessage = 'Password needs to be bigger than 6 digits.';
      return false;
    }
    return true;
  }

  bool _isSmallThanSixDigits() {
    return _password.trim().length < 6;
  }
}