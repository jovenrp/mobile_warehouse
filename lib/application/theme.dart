import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_colors.dart';
import 'package:mobile_warehouse/core/domain/utils/constants/app_theme.dart';
import 'package:mobile_warehouse/core/presentation/widgets/theme_state.dart';
import 'package:mobile_warehouse/generated/fonts.gen.dart';

ThemeState getThemeState(
  bool isTablet,
  ThemeData theme,
  ThemeData themeDark,
) {
  if (isTablet) {
    return ThemeStateTablet(
      theme: theme,
      themeDark: themeDark,
      devicePixelRatio: window.devicePixelRatio,
    );
  }
  return ThemeState(
    theme: theme,
    themeDark: themeDark,
    devicePixelRatio: window.devicePixelRatio,
  );
}

/// NAME       SIZE   WEIGHT   SPACING  2018 NAME
/// display4   112.0  thin     0.0      headline1
/// display3   56.0   normal   0.0      headline2
/// display2   45.0   normal   0.0      headline3
/// display1   34.0   normal   0.0      headline4
/// headline   24.0   normal   0.0      headline5
/// title      20.0   medium   0.0      headline6
/// subhead    16.0   normal   0.0      subtitle1
/// body2      14.0   medium   0.0      body1
/// body1      14.0   normal   0.0      body2
/// caption    12.0   normal   0.0      caption
/// button     14.0   medium   0.0      button
/// subtitle   14.0   medium   0.0      subtitle2
/// overline   10.0   normal   0.0      overline

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.secondaryColor,
    hintColor: AppColors.gomoRed,
    splashColor: AppColors.gomoRed.withOpacity(0.25),
    backgroundColor: AppColors.secondaryColor,
    scaffoldBackgroundColor: AppColors.secondaryColor,
    dialogBackgroundColor: AppColors.white,
    bottomAppBarColor: AppColors.white,
    indicatorColor: AppColors.bodyColor,
    snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
      actionTextColor: AppColors.white,
      backgroundColor: AppColors.darkGrey,
    ),
    fontFamily: FontFamily.proximaNova,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: AppColors.gomoRed,
      ),
      /*textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          // fontFamily: Variables.kBaseFontFamily,
          fontFamily: FontFamily.proximaNova,
          fontWeight: FontWeight.normal,
          fontSize: 20.0,
        ),
      ),*/
    ),
    cardTheme: CardTheme(
      elevation: 4.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    textTheme: _textTheme(color: AppColors.white),
    primaryTextTheme: _textTheme(color: AppColors.bodyColor),
    buttonTheme: ButtonThemeData(
      height: 46,
      padding: const EdgeInsets.symmetric(
        // vertical: 14.0,
        horizontal: 32.0,
      ),
      textTheme: ButtonTextTheme.primary,
      buttonColor: AppColors.gomoRed,
      disabledColor: AppColors.grayFour.withOpacity(0.6),
      shape: const StadiumBorder(),
    ),
    textSelectionTheme: AppThemeConstants.textSelection,
    // popupMenuTheme: PopupMenuThemeData(
    //   textStyle: TextStyle(
    //     fontSize: 12,
    //   ),
    // ),
  );
}

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.white,
    hintColor: AppColors.gomoRed,
    splashColor: AppColors.gomoRed.withOpacity(0.25),
    backgroundColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.white,
    dialogBackgroundColor: AppColors.white,
    bottomAppBarColor: AppColors.white,
    indicatorColor: AppColors.bodyColor,
    fontFamily: FontFamily.proximaNova,
    snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: FontFamily.proximaNova,
      ),
      actionTextColor: AppColors.white,
      backgroundColor: AppColors.violet,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: AppColors.gomoRed,
      ),
      /*textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          // fontFamily: Variables.kBaseFontFamily,
          fontFamily: FontFamily.proximaNova,
          fontWeight: FontWeight.normal,
          fontSize: 20.0,
        ),
      ),*/
    ),
    cardTheme: CardTheme(
      elevation: 4.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
//        side: BorderSide(
//          width: 0.5,
//          color: AppColors.grayFour
//        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    textTheme: _textTheme(color: AppColors.bodyColor),
    primaryTextTheme: _textTheme(color: AppColors.bodyColor),
    buttonTheme: ButtonThemeData(
      height: 46.0,
      padding: const EdgeInsets.symmetric(
        // vertical: 16.0,
        horizontal: 32.0,
      ),
      textTheme: ButtonTextTheme.primary,
      buttonColor: AppColors.gomoRed,
      disabledColor: AppColors.gomoRed.withOpacity(0.5),
      shape: const StadiumBorder(),
    ),
    splashFactory: InkRipple.splashFactory,
    textSelectionTheme: AppThemeConstants.textSelection,
  );
}

TextTheme _textTheme({Color? color}) {
  return TextTheme(
    headline1: TextStyle(
      color: color,
      fontSize: 36,
    ),
    headline2: TextStyle(
      color: color,
      fontSize: 24,
    ),
    headline3: TextStyle(
      color: color,
      fontSize: 20,
    ),
    headline4: TextStyle(
      color: color,
      fontSize: 18,
      height: 20 / 18,
    ),
    bodyText1: TextStyle(
      color: color,
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      color: color,
      fontSize: 14,
      height: 16 / 14,
    ),
    caption: TextStyle(
      color: color,
      fontSize: 12,
    ),
    button: TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    overline: TextStyle(
      color: color,
      fontSize: 10,
      letterSpacing: 0.2,
    ),
  );
}
