

import 'package:flutter/material.dart';
import 'package:zoncan/config/config.dart';

class Fonts {
  late double fontScale = 1.0;
  static Fonts instance = Fonts();

  // Font constants
  static const kFontLight = FontWeight.w300;
  static const kFontRegular = FontWeight.w400;
  static const kFontMedium = FontWeight.w500;
  static const kFontSemiBold = FontWeight.w600;
  static const kFontBold = FontWeight.w900;

  static const TextStyle _fontStyle = TextStyle(
      inherit: false,
      // color: Colorize.foregroundColor,
      fontFamily: kDefaultFont,
      fontFamilyFallback: [kDefaultFallBackFont],
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal);

  TextStyle headline1() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 96.0 * fontScale,
      letterSpacing: -1.5,
      fontWeight: kFontLight,
    );
  }

  TextStyle headline2() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 60.0 * fontScale,
      letterSpacing: -0.5,
      fontWeight: kFontLight,
    );
  }

  TextStyle headline3() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 48.0 * fontScale,
      letterSpacing: 0.0,
      fontWeight: kFontRegular,
    );
  }

  TextStyle headline4() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 34.0 * fontScale,
      letterSpacing: 0.25,
      fontWeight: kFontRegular,
    );
  }

  TextStyle headline5() {
    return _fontStyle.copyWith(
      inherit: true,
      letterSpacing: 0.0,
      fontSize: 24.0 * fontScale,
      fontWeight: kFontRegular,
    );
  }

  TextStyle headline6() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 20.0 * fontScale,
      letterSpacing: 0.15,
      fontWeight: kFontRegular,
    );
  }

  TextStyle subtitle1() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 16.0 * fontScale,
      letterSpacing: 0.15,
      fontWeight: kFontRegular,
    );
  }

  TextStyle subtitle2() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 14.0 * fontScale,
      letterSpacing: 0.1,
      fontWeight: kFontMedium,
    );
  }

  TextStyle body1() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 16.0 * fontScale,
      letterSpacing: 0.5,
      fontWeight: kFontRegular,
    );
  }

  TextStyle body2() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 14.0 * fontScale,
      letterSpacing: 0.25,
      fontWeight: kFontMedium,
    );
  }

  TextStyle button() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 14.0 * fontScale,
      letterSpacing: 1.25,
      fontWeight: kFontMedium,
    );
  }

  TextStyle caption() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 12.0 * fontScale,
      letterSpacing: 0.4,
      fontWeight: kFontRegular,
    );
  }

  TextStyle overline() {
    return _fontStyle.copyWith(
      inherit: true,
      fontSize: 12.0 * fontScale,
      letterSpacing: 1.5,
      fontWeight: kFontRegular,
    );
  }
}
