import 'dart:async';

import 'package:ecommerce_app/presentation/base/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  // * Here we use 'broadcast' because we want to listen to the stream multiple times in our view
  // We will be continuously listening to the stream to check the validity of username and password

  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {}

  @override
  void login() {}

  @override
  void setPassword(String password) {
    // Here we add the password to the sink...
    inputPassword.add(password);
  }

  @override
  void setUsername(String username) {
    // Here we add the username to the sink...
    inputPassword.add(username);
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Stream<bool> get isPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));
// Here we are mapping the stream to a boolean value,
// streamcontroller returns a stream of string, so we are mapping it to a boolean value

  @override
  Stream<bool> get isUsernameValid => _usernameStreamController.stream
      .map((username) => _isUsernameValid(username));

// * Private Functions
  bool _isPasswordValid(String password) {
    return password.length > 6;
  }

  bool _isUsernameValid(String username) {
    return username.length > 4;
  }
}

// Inputs
abstract class LoginViewModelInputs {
  void setUsername(String username);
  void setPassword(String password);
  void login();

  Sink get inputUsername;
  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  // to check the validity of username and password
  Stream<bool> get isUsernameValid;
  Stream<bool> get isPasswordValid;
}
