import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/app/app.dart';
import 'package:ecommerce_app/app/di.dart';
import 'package:ecommerce_app/core.dart/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setup();
  runApp(
    EasyLocalization(
      supportedLocales: const [englishLocal, nepaliLocal],
      path: localizationAssetsPath,
      child: Phoenix(
        child: MyApp(),
      ),
    ),
  );
}
