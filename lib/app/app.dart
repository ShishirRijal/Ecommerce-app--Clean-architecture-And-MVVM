import 'package:ecommerce_app/core.dart/route/app_rotues.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal(); // private constructor

  static const MyApp instance = MyApp._internal(); // singleton instance

  // This ensures MyApp is a singleton and and when accessed anywhere returns the same instance
  factory MyApp() => instance; // factory for singleton

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
