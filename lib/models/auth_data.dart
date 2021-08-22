enum AuthMode {
  LOGIN, 
  SIGNUP,
}

class AuthData {
  String? name;
  String? email;
  String? password;
  AuthMode? _mode = AuthMode.LOGIN;

  AuthData({
    this.name,
    this.email,
    this.password,
  });

  bool get isSignup {
    return _mode == AuthMode.SIGNUP;
  }

  bool get isLogin {
    return _mode == AuthMode.LOGIN;
  }

  void toggleMode() {
    _mode = _mode == AuthMode.LOGIN ? AuthMode.SIGNUP : AuthMode.LOGIN;
  }

  @override
  String toString() {
    return 'AuthData(name: $name, email: $email, password: $password, _mode: $_mode)';
  }
}
