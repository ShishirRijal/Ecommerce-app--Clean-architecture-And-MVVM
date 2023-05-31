import 'dart:async';
import 'package:ecommerce_app/app/di.dart';
import 'package:flutter/material.dart';

import '../../app/app_prefs.dart';
import '../../core.dart/core.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _appPreferences = getIt<AppPreferences>();
  // This function will route to the onboarding screen
  // after dealy of few seconds as specified..
  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        // go to the main route
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
        _appPreferences.isOnboardingScreenViewed().then((isViewed) {
          if (isViewed) {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _goNext();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }
}
