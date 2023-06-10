import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/app/di.dart';
import 'package:flutter/material.dart';

import '../../presentation/presentation.dart';
import '../core.dart';

// This class contains all the routes in our app
class Routes {
  static const String splashRoute = '/';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String mainRoute = '/main';
  static const String storeDetailRoute = '/storeDetail';
}

//  The getRoute method will return a route based on the route name
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: ((context) => const SplashView()));
      case Routes.onboardingRoute:
        return MaterialPageRoute(
            builder: ((context) => const OnboardingView()));
      case Routes.mainRoute:
        initHome();
        return MaterialPageRoute(builder: ((context) => const MainView()));
      case Routes.loginRoute:
        initLogin();
        return MaterialPageRoute(builder: ((context) => const LoginView()));
      case Routes.registerRoute:
        initRegister();
        return MaterialPageRoute(builder: ((context) => const RegisterView()));
      case Routes.forgotPasswordRoute:
        initForgotPassword();
        return MaterialPageRoute(
            builder: ((context) => const ForgotPasswordView()));
      case Routes.storeDetailRoute:
        initStoreDetail();
        return MaterialPageRoute(
            builder: ((context) => const StoreDetailView()));

      default:
        return undefinedRoute();
    }
  }
}

Route<dynamic> undefinedRoute() {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(
        title: Text(AppString.noRouteFound.tr()),
      ),
      body: Center(
        child: Text(AppString.noRouteFound.tr(),
            style: getSemiBoldTextStyle(
              color: ColorManager.error,
            )),
      ),
    ),
  );
}
