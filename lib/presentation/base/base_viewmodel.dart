abstract class BaseViewModel with BaseViewModelInputs, BaseViewModelOutputs {
  // shared functions and methods that are common to all view models
}

abstract class BaseViewModelInputs {
  // inputs
  void start(); // Will be called when the viewmodel is initialized
  void dispose(); // Will be called when the viewmodel is disposed
}

abstract class BaseViewModelOutputs {
  // outputs
}
