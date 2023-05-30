import 'package:ecommerce_app/app/app.dart';
import 'package:ecommerce_app/app/di.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(
    MyApp(),
  );
}
