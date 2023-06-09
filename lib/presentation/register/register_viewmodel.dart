import 'dart:async';
import 'dart:io';

import 'package:ecommerce_app/presentation/presentation.dart';
import 'package:ecommerce_app/app/helper_functions.dart' as util;
import '../../core.dart/core.dart';
import '../../domain/usecases/register_usecase.dart';
import '../common/state_renderer/state_render_implementer.dart';
import '../common/state_renderer/state_renderer.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);

  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();

  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();

  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var registerObject = RegisterObject(
      countryMobileCode: '',
      username: '',
      email: '',
      password: '',
      profilePicture: '',
      mobileNumber: '');

  @override
  void start() {
    // view tells state renderer, please show the content of the screen
    // inputState.add(ContentState());
  }

  @override
  void dispose() {
    _isAllInputsValidStreamController.close();
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
    super.dispose();
  }

  //! Inputs
  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    return (await _registerUseCase(RegisterUseCaseInput(
      email: registerObject.email,
      password: registerObject.password,
      mobileNumber: registerObject.mobileNumber,
      profilePicture: registerObject.profilePicture,
      username: registerObject.username,
      countryMobileCode: registerObject.countryMobileCode,
    )))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.popupErrorState, failure.message)),
                }, (data) {
      inputState.add(ContentState());
      // navigate to main screen
      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUsername => _userNameStreamController.sink;

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      // update register view object with countryCode value
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      // reset countryCode value in register view object
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (util.isEmailValid(email)) {
      // update register view object with email value
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      // update register view object with mobileNumber value
      registerObject = registerObject.copyWith(
          mobileNumber: mobileNumber); // using data class like kotlin
    } else {
      // reset mobileNumber value in register view object
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      // update register view object with password value
      registerObject = registerObject.copyWith(
          password: password); // using data class like kotlin
    } else {
      // reset password value in register view object
      registerObject = registerObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File file) {
    inputProfilePicture.add(file);
    if (file.path.isNotEmpty) {
      // update register view object with profilePicture value
      registerObject = registerObject.copyWith(
          profilePicture: file.path); // using data class like kotlin
    } else {
      // reset profilePicture value in register view object
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUsername.add(userName);
    if (_isUsernameValid(userName)) {
      // update register view object with username value
      registerObject = registerObject.copyWith(
          username: userName); // using data class like kotlin
    } else {
      // reset username value in register view object
      registerObject = registerObject.copyWith(username: "");
    }
    _validate();
  }

//! Outputs

  @override
  Stream<bool> get isAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _validateAllInputs());

  @override
  Stream<bool> get isEmailValid =>
      _emailStreamController.stream.map((email) => util.isEmailValid(email));
  @override
  Stream<String?> get emailErrorText =>
      isEmailValid.map((email) => email ? null : AppString.invalidEmail);

  @override
  Stream<bool> get isMobileNumberValid => _mobileNumberStreamController.stream
      .map((number) => _isMobileNumberValid(number));

  @override
  Stream<bool> get isPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<File> get outputProfilePicture =>
      _profilePictureStreamController.stream.map((picture) => picture);

  @override
  Stream<bool> get isUsernameValid => _userNameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  Stream<String?> get mobileNumberErrorText => isMobileNumberValid
      .map((phone) => phone ? null : AppString.invalidMobileNumber);

  @override
  Stream<String?> get passwordErrorText => isPasswordValid
      .map((password) => password ? null : AppString.invalidPassword);
  @override
  Stream<String?> get usernameErrorText => isUsernameValid
      .map((username) => username ? null : AppString.invalidUsername);

  //! Private Functions
  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _isUsernameValid(String username) {
    return username.length >= 6;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length == 10;
  }

  bool _validateAllInputs() {
    return registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.username.isNotEmpty &&
        registerObject.countryMobileCode.isNotEmpty;
  }

  _validate() {
    inputIsAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInputs {
  register();

  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File file);

  Sink get inputUsername;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputIsAllInputsValid;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get isUsernameValid;
  Stream<String?> get usernameErrorText;

  Stream<bool> get isMobileNumberValid;
  Stream<String?> get mobileNumberErrorText;

  Stream<bool> get isEmailValid;
  Stream<String?> get emailErrorText;

  Stream<bool> get isPasswordValid;
  Stream<String?> get passwordErrorText;

  Stream<File> get outputProfilePicture;
  Stream<bool> get isAllInputsValid;
}
