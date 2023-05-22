import 'package:flutter/material.dart';

class ColorManager {
  // ! We can use the below approach to define our colors using hex values
  // ! And later use the extension method to convert the hex value to a Color object
  // ! This is a good approach as it allows us to use the hex value as a string
  // ! and later convert it to a Color object

  // static const Color primaryColor = '#FF0000'; // This is a hex color
  // Let's use a approach with the extension method
  // static final Color primary = HexColor.fromHex('#ED9728');
  // static final Color darkGrey = HexColor.fromHex('#525252');
  // static final Color grey = HexColor.fromHex('#737477');
  // static final Color lightGrey = HexColor.fromHex('#9E9E9E');

  // * However, I'd prefer to use the below approach to define my colors
  static const Color primary = Color(0XFFED9728);
  static const Color darkGrey = Color(0XFF525252);
  static const Color grey = Color(0XFF737477);
  static const Color lightGrey = Color(0XFF9E9E9E);
  // more shades...
  static const Color darkPrimary = Color(0XFFD17D11);
  static const Color grey1 = Color(0XFF707070);
  static const Color grey2 = Color(0XFF797979);
  static const Color white = Color(0XFFFFFFFF);
  static const Color error = Color(0XFFE61F34);
  static const Color black = Color(0XFF000000);
}

// let's write a extension that will convert our hex color to a Color object
extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceFirst('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
