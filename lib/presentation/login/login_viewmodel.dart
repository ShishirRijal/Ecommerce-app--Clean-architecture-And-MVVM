import 'dart:async';

import 'package:ecommerce_app/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app/presentation/base/base_viewmodel.dart';
import 'package:ecommerce_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:ecommerce_app/presentation/data_classes/data_classes.dart';

import '../common/state_renderer/state_render_implementer.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  // * Here we are injecting the login usecase, so that we can use it to login the user
  // * it provides us with the login functionality ...
  LoginUseCase loginUseCase;
  LoginViewModel({required this.loginUseCase});

  // * Here we use 'broadcast' because we want to listen to the stream multiple times in our view
  // We will be continuously listening to the stream to check the validity of username and password

  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllFieldsValidStreamController =
      StreamController<void>.broadcast();
  // login object
  var loginObject = LoginObject(username: "", password: "");

  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
    _isAllFieldsValidStreamController.close();
  }

  @override
  void start() {}

  @override
  // Future<Either<Failure, Authentication>>
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    return (await loginUseCase(LoginUseCaseInput(
            email: loginObject.username, password: loginObject.password)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.popupErrorState, failure.message)),
                },
            (data) => {
                  inputState.add(ContentState()),
                });
  }

  @override
  void setPassword(String password) {
    // Here we add the password to the sink...
    inputPassword.add(password);
    // updating the login object with new password
    loginObject = loginObject.copyWith(password: password);
    // Everytime we update the password we validate the fields
    _validate();
  }

  @override
  void setUsername(String username) {
    // Here we add the username to the sink...
    inputUsername.add(username);
    // updating the login object with new username
    loginObject = loginObject.copyWith(username: username);

    _validate();
  }

  @override
  Sink get inputAllinputFields => _isAllFieldsValidStreamController.sink;

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

  @override
  Stream<bool> get isAllInputsValid =>
      _isAllFieldsValidStreamController.stream.map((_) => _isAllFieldsValid());

// * Private Functions
  bool _isPasswordValid(String password) {
    return password.length > 6;
  }

  bool _isUsernameValid(String username) {
    return username.length > 4;
  }

  bool _isAllFieldsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUsernameValid(loginObject.username);
  }

  _validate() {
    inputAllinputFields.add(null);
  }
}

// Inputs
abstract class LoginViewModelInputs {
  void setUsername(String username);
  void setPassword(String password);
  login();

  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputAllinputFields;
}

abstract class LoginViewModelOutputs {
  // to check the validity of username and password
  Stream<bool> get isUsernameValid;
  Stream<bool> get isPasswordValid;
  Stream<bool> get isAllInputsValid;
}
