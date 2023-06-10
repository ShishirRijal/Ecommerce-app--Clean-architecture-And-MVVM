import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/app/app_prefs.dart';
import 'package:ecommerce_app/app/di.dart';
import 'package:ecommerce_app/core.dart/core.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); // private constructor

  static const MyApp instance = MyApp._internal(); // singleton instance

  // This ensures MyApp is a singleton and and when accessed anywhere returns the same instance
  factory MyApp() => instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPref = getIt<AppPreferences>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appPref.getLocal().then((locale) {
      setState(() {
        context.setLocale(locale);
      });
    });
  }

  // factory for singleton
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
