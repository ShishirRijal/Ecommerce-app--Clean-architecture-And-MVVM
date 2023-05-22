import 'package:flutter/material.dart';

import '../core.dart';

TextStyle _getTextStyle(
    String fontFamily, double size, Color color, FontWeight fontWeight) {
  return TextStyle(
    color: color,
    fontFamily: fontFamily,
    fontSize: size,
    fontWeight: fontWeight,
  );
}

// Light Text
TextStyle getLightTextStyle({
  String fontFamily = FontFamilyManager.montserrat,
  double size = FontSize.s12,
  Color color = ColorManager.lightGrey,
  FontWeight fontWeight = FontWeightManager.light,
}) {
  return _getTextStyle(fontFamily, size, color, fontWeight);
}

// Regular Text Style
TextStyle getRegularTextStyle({
  String fontFamily = FontFamilyManager.montserrat,
  double size = FontSize.s14,
  Color color = ColorManager.grey,
  FontWeight fontWeight = FontWeightManager.normal,
}) {
  return _getTextStyle(fontFamily, size, color, fontWeight);
}

// Medium Text
TextStyle getMediumTextStyle({
  String fontFamily = FontFamilyManager.montserrat,
  double size = FontSize.s16,
  Color color = ColorManager.grey,
  FontWeight fontWeight = FontWeightManager.medium,
}) {
  return _getTextStyle(fontFamily, size, color, fontWeight);
}

// SemiBold Text
TextStyle getSemiBoldTextStyle({
  String fontFamily = FontFamilyManager.montserrat,
  double size = FontSize.s18,
  Color color = ColorManager.darkGrey,
  FontWeight fontWeight = FontWeightManager.medium,
}) {
  return _getTextStyle(fontFamily, size, color, fontWeight);
}

// Bold Text
TextStyle getBoldTextStyle({
  String fontFamily = FontFamilyManager.montserrat,
  double size = FontSize.s20,
  Color color = ColorManager.darkGrey,
  FontWeight fontWeight = FontWeightManager.bold,
}) {
  return _getTextStyle(fontFamily, size, color, fontWeight);
}
