import 'dart:async';

import 'package:ecommerce_app/presentation/common/state_renderer/state_render_implementer.dart';

abstract class BaseViewModel with BaseViewModelInputs, BaseViewModelOutputs {
  // shared functions and methods that are common to all view models

  // to display the correct state of the view depending on the state of the view model
  final StreamController _inputStateStreamController =
      StreamController<FlowState>.broadcast();

  // we don't want  every screen to override the inputState and output state, so we override it here
  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void start() {
    // view tell state renderer, please render the content of screen
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _inputStateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  // inputs
  void start(); // Will be called when the viewmodel is initialized
  void dispose(); // Will be called when the viewmodel is disposed

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  // outputs
  Stream get outputState;
}
