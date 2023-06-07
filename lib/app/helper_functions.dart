import 'dart:io';

import 'package:ecommerce_app/domain/model/model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

Future<Device> getDeviceInfo() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  try {
    // if android
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return Device(
        "${androidInfo.brand} ${androidInfo.model}",
        androidInfo.id,
        androidInfo.version.codename,
      );
    }
    // is IOS
    else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return Device(
        "${iosInfo.name} ${iosInfo.model}",
        iosInfo.identifierForVendor ?? 'Unknown',
        iosInfo.systemVersion,
      );
    } else {
      return Device(name, identifier, version);
    }
  } on PlatformException catch (_) {
    // return default value here
    return Device(name, identifier, version);
  }
}

bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
