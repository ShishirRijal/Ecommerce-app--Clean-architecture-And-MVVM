import 'dart:async';

import 'package:ecommerce_app/presentation/base/base_viewmodel.dart';

import '../../core.dart/core.dart';
import '../../domain/model/model.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModelOutputs {
  // stream controller
  final _streamController = StreamController<SlideViewObject>();
  late List<SliderObject> _list;
  int _currentIndex = 0;

  // ! Inputs
  @override
  void start() {
    // initialize the list with slider data
    _list = _getSlideObjects();
    // Now, send this data to the view
    _postDataToView();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  int goNext() {
    _currentIndex++;
    if (_currentIndex >= _list.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    _currentIndex--;
    if (_currentIndex < 0) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    // since the selected slide is changed, we need to send the data to the view
    _postDataToView();
  }

  @override
  Sink get inputSlideViewObject => _streamController.sink;

  // ! Outputs
  @override
  Stream<SlideViewObject> get outputSlideViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

// ! Private Functions
  List<SliderObject> _getSlideObjects() => [
        SliderObject(AppString.onboardingTitle1, AppString.onboardingSubtitle1,
            SvgAssets.onboardingLogo1),
        SliderObject(AppString.onboardingTitle2, AppString.onboardingSubtitle2,
            SvgAssets.onboardingLogo2),
        SliderObject(AppString.onboardingTitle3, AppString.onboardingSubtitle3,
            SvgAssets.onboardingLogo3),
        SliderObject(AppString.onboardingTitle4, AppString.onboardingSubtitle4,
            SvgAssets.onboardingLogo4),
      ];

  void _postDataToView() {
    inputSlideViewObject.add(SlideViewObject(
        _list[_currentIndex], _list, _list.length, _currentIndex));
  }
}

// Inputs -> The order that our viewmodel will receive from our view
// To put simply, the inputs are the events that our viewmodel will receive from our view.
abstract class OnboardingViewModelInputs {
  // When user clicks on right arrow or swipes right, go to next page
  int goNext();
  // When user clicks on left arrow or swipes left, go to previous page
  int goPrevious();
  // When the page is changed, go to that new page
  void onPageChanged(int index);
  // Widget getProperCircle(int currentIndex, int index);

// This is the way to add the data to the stream
// To put simply, sink is the input to the stream controller
  Sink get inputSlideViewObject; // input of stream
}

// Outputs -> The data or information that will be sent from our viewmodel to the view
// To put simply, the outputs are the data that our viewmodel will send to our view.
abstract class OnboardingViewModelOutputs {
  // Simply, stream is the output of the stream controller
  // and we can listen to this stream in our view
  Stream<SlideViewObject> get outputSlideViewObject; // output of stream
}

class SlideViewObject {
  SliderObject currentSlide;
  List<SliderObject> list;
  int numberOfSlides;
  int currentIndex;
  SlideViewObject(
      this.currentSlide, this.list, this.numberOfSlides, this.currentIndex);
}
