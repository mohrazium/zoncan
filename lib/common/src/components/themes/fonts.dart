
import 'package:flutter/material.dart';
import 'package:zoncan/constants/constants.dart' show FontConstants;

import 'colorize.dart';

class Fonts {
  static double fontScale = 1.0;//TODO:define scale for production
  Fonts._();
  static const String sahelFontFamily = "Sahel";
  static const String vazirFontFamily = "Vazir";
  // Font constants
  static const kFontLight = FontWeight.w300;
  static const kFontRegular = FontWeight.w400;
  static const kFontMedium = FontWeight.w500;
  static const kFontSemiBold = FontWeight.w600;
  static const kFontBold = FontWeight.w900;

  static const TextStyle _fontStyle = TextStyle(
      inherit: false,
      color: Colorize.foregroundColor,
      fontFamily: FontConstants.sahel,
      fontFamilyFallback: [FontConstants.vazir],
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal);

  static TextStyle headline1() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 96.0 / fontScale,
      letterSpacing: -1.5,
      fontWeight: kFontLight,
    );
  }

  static TextStyle headline2() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 60.0 / fontScale,
      letterSpacing: -0.5,
      fontWeight: kFontLight,
    );
  }

  static TextStyle headline3() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 48.0 / fontScale,
      letterSpacing: 0.0,
      fontWeight: kFontRegular,
    );
  }

  static TextStyle headline4() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 34.0 / fontScale,
      letterSpacing: 0.25,
      fontWeight: kFontRegular,
    );
  }

  static TextStyle headline5() {
    return _fontStyle.copyWith(
      inherit: true,
      letterSpacing: 0.0,
      fontSize: 24.0 / fontScale,
      fontWeight: kFontRegular,
    );
  }

  static TextStyle headline6() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 20.0 / fontScale,
      letterSpacing: 0.15,
      fontWeight: kFontRegular,
    );
  }

  static TextStyle subtitle1() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 16.0 / fontScale,
      letterSpacing: 0.15,
      fontWeight: kFontRegular,
    );
  }

  static TextStyle subtitle2() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 14.0 / fontScale,
      letterSpacing: 0.1,
      fontWeight: kFontMedium,
    );
  }

  static TextStyle body1() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 16.0 / fontScale,
      letterSpacing: 0.5,
      fontWeight: kFontRegular,
    );
  }

  static TextStyle body2() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 14.0 / fontScale,
      letterSpacing: 0.25,
      fontWeight: kFontMedium,
    );
  }

  static TextStyle button() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 14.0 / fontScale,
      letterSpacing: 1.25,
      fontWeight: kFontMedium,
    );
  }

  static TextStyle caption() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 12.0 / fontScale,
      letterSpacing: 0.4,
      fontWeight: kFontRegular,
    );
  }

  static TextStyle overline() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 12.0 / fontScale,
      letterSpacing: 1.5,
      fontWeight: kFontRegular,
    );
  }
}
