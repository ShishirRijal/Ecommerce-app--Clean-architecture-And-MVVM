import 'dart:async';

import 'package:ecommerce_app/core.dart/resources/asset_manager.dart';
import 'package:flutter/material.dart';

import '../../core.dart/core.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // This function will route to the onboarding screen
  // after dealy of few seconds as specified..
  _goNext() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
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
