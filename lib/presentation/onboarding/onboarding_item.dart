import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core.dart/core.dart';
import '../../domain/model/model.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem(this.sliderObject, {super.key});
  final SliderObject sliderObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s80),
        // Title
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        // Caption
        Padding(
          padding: const EdgeInsets.all(AppPadding.p15),
          child: Text(
            sliderObject.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: AppSize.s20),
        // Image
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p10, vertical: AppPadding.p20),
          child: SvgPicture.asset(
            sliderObject.imagePath,
          ),
        ),
        // Slider bottons

        const SizedBox(height: AppSize.s40),
      ],
    );
  }
}
