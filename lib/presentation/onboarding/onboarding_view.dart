import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../core.dart/core.dart';
import 'onboarding_item.dart';
import 'onboarding_viewmodel.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  final OnboardingViewModel _viewModel = OnboardingViewModel();
  final AppPreferences _appPreferences = getIt<AppPreferences>();

  @override
  void initState() {
    super.initState();
    _appPreferences.setOnboardingScreenViewed();
    _viewModel.start(); // initialize the view model (bind the stream)
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void onSkip() {
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }

  Widget _getContentWidget(SlideViewObject? sliderViewObject) {
    return sliderViewObject == null
        ? Container()
        : Scaffold(
            body: PageView.builder(
              controller: _pageController,
              itemCount: sliderViewObject.numberOfSlides,
              onPageChanged: (index) {
                _viewModel.onPageChanged(index);
              },
              itemBuilder: (context, index) {
                return OnboardingItem(sliderViewObject.list[index]);
              },
            ),
            bottomSheet: SizedBox(
              // color: ColorManager.white,
              height: AppSize.s100,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: AppPadding.p15),
                        child: Text(
                          AppString.skip.tr(),
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  _getBottomSheetWidget(sliderViewObject)
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SlideViewObject>(
      stream: _viewModel.outputSlideViewObject,
      builder: (context, snapshot) => _getContentWidget(snapshot.data),
    );
  }

  Widget _getBottomSheetWidget(SlideViewObject sliderViewObject) {
    return Expanded(
      child: Container(
        color: ColorManager.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // left arrow
            GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(SvgAssets.leftArrow),
              ),
              onTap: () {
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: Delay.d300, curve: Curves.easeOut);
              },
            ),
            // Cicrle Indicator
            Row(
              children: [
                for (int i = 0; i < sliderViewObject.numberOfSlides; i++)
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: getProperCircle(sliderViewObject.currentIndex, i),
                  ),
              ],
            ),
            //right arrow
            GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(SvgAssets.rightArrow),
              ),
              onTap: () {
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: Delay.d300, curve: Curves.easeIn);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget getProperCircle(int currentIndex, int index) {
  if (index == currentIndex) {
    return SvgPicture.asset(SvgAssets.solidCircle);
  } else {
    return SvgPicture.asset(SvgAssets.hollowCircle);
  }
}
