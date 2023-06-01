import 'dart:async';

import 'package:ecommerce_app/domain/usecases/forgot_password_usecase.dart';
import 'package:ecommerce_app/presentation/common/state_renderer/state_render_implementer.dart';

import '../base/base_viewmodel.dart';
import '../common/state_renderer/state_renderer.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  String email = "";

  @override
  void dispose() {
    _emailStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState()); // * Initial state
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    return (await _forgotPasswordUseCase(email)).fold(
        (failure) => inputState.add(
              ErrorState(StateRendererType.popupErrorState, failure.message),
            ),
        (success) => inputState.add(ContentState()));
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get isEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
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
