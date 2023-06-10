import 'package:flutter/material.dart';

import '../core.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //Main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primary.withOpacity(0.7),
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.primary.withOpacity(0.7),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManager.grey,
      error: ColorManager.error,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.primary.withOpacity(0.7),
      titleTextStyle:
          getRegularTextStyle(color: ColorManager.white, size: 16.0),
    ),

    // card theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: ColorManager.primary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.primary.withOpacity(0.7),
    ),
    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: getRegularTextStyle(color: ColorManager.white),
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s8))),
    ),

    //input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppSize.s8),
      hintStyle: getRegularTextStyle(color: ColorManager.grey1),
      labelStyle: getSemiBoldTextStyle(),
      errorStyle: getRegularTextStyle(color: ColorManager.error),
      //enableborder
      enabledBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(width: AppSize.s1_5, color: ColorManager.grey),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      //  focused border
      focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(width: AppSize.s1_5, color: ColorManager.primary),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      // error border
      errorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(width: AppSize.s1_5, color: ColorManager.error),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      //focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(width: AppSize.s1_5, color: ColorManager.primary),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),

    //text theme
    textTheme: TextTheme(
      headlineLarge: getSemiBoldTextStyle(), // headline 1
      headlineMedium: getBoldTextStyle(
        color: ColorManager.white,
        size: FontSize.s18,
      ),

      headlineSmall: getBoldTextStyle(
        color: ColorManager.primary,
        size: FontSize.s16,
      ), // headline 3
      displayLarge: getRegularTextStyle(
          color: ColorManager.primary, size: FontSize.s14), // headline4
      labelLarge: getMediumTextStyle(), // subtitle 1
      labelMedium:
          getRegularTextStyle(color: ColorManager.primary), // subtitle 2
      labelSmall: getRegularTextStyle(color: ColorManager.grey1), // caption
      bodyLarge: getRegularTextStyle(), // body text 1
      bodyMedium:
          getMediumTextStyle(color: ColorManager.lightGrey), // body text 2
    ),
  );
}
