import 'dart:async';

import 'package:flutter/material.dart';

import '../base/base_viewmodel.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  @override
  void dispose() {
    _emailStreamController.close();
  }

  @override
  void start() {
    //
  }

  @override
  void forgotPassword() {
    debugPrint("Forgot password clicked");
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get isEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  void setEmail(String email) {
    inputEmail.add(email);
  }

  // * Private functions
  bool _isEmailValid(String email) {
    return email.contains("@") && email.length > 4;
  }
}

abstract class ForgotPasswordViewModelInputs {
  void setEmail(String email);
  void forgotPassword();
  Sink get inputEmail;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get isEmailValid;
}
