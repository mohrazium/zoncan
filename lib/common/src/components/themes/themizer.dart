import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoncan/constants/constants.dart';

import 'colorize.dart';
import 'fonts.dart';

class Themizer {
  Themizer._();
  Color invert(Color color) {
    final r = 255 - color.red;
    final g = 255 - color.green;
    final b = 255 - color.blue;

    return Color.fromARGB((color.opacity * 255).round(), r, g, b);
  }

  static ThemeData get light => ThemeData(
        fontFamily: FontConstants.sahel,
        brightness: Brightness.light,
        // primarySwatch: ,
        primaryColor: Colorize.primaryColor,
        secondaryHeaderColor: Colorize.accentColor,
        scaffoldBackgroundColor: Colorize.backgroundColor,
        backgroundColor: Colorize.backgroundColor[300],
        iconTheme: _Themizer._().iconTheme,
        appBarTheme: _Themizer._().appBarTheme,
        textTheme: _Themizer._().textTheme,
        elevatedButtonTheme: _Themizer._().elevatedButtonThemeData,

        inputDecorationTheme: _Themizer._().inputDecorationTheme,
      );

  static ThemeData get dark => ThemeData(
        fontFamily: FontConstants.sahel,
        brightness: Brightness.light,
        // primarySwatch: ,
        primaryColor: Colorize.primaryColor,
        secondaryHeaderColor: Colorize.accentColor,
        scaffoldBackgroundColor: Colorize.backgroundColor,
        backgroundColor: Colorize.backgroundColor[300],
        iconTheme: _Themizer._().iconTheme,
        appBarTheme: _Themizer._().appBarTheme,
        textTheme: _Themizer._().textTheme,
        elevatedButtonTheme: _Themizer._().elevatedButtonThemeData,

        inputDecorationTheme: _Themizer._().inputDecorationTheme,
      );
  static TextStyle get textStyle =>
      const TextStyle(fontFamily: FontConstants.sahel);
}

class _Themizer {
  _Themizer._();
  final appBarTheme = AppBarTheme(
    color: Colorize.backgroundColor[300],
    elevation: 5.0,
    shadowColor: Colorize.foregroundColor[300],
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );

  final iconTheme = IconThemeData(color: Colorize.foregroundColor[400]);

  TextTheme get textTheme => TextTheme(
      headline1: Fonts.headline1(),
      headline2: Fonts.headline2(),
      headline3: Fonts.headline3(),
      headline4: Fonts.headline4(),
      headline5: Fonts.headline5(),
      headline6: Fonts.headline6(),
      bodyText1: Fonts.body1(),
      bodyText2: Fonts.body2(),
      subtitle1: Fonts.subtitle1(),
      subtitle2: Fonts.subtitle2(),
      caption: Fonts.caption());

  InputDecorationTheme get inputDecorationTheme => const InputDecorationTheme(
        contentPadding: EdgeInsets.all(kPadding / 3),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: Colorize.accentColor),
          borderRadius: BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: Colorize.errorColor),
          borderRadius: BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1.5, color: Colorize.primaryColorShade300),
          borderRadius: BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1.5, color: Colorize.primaryColorShade300),
          borderRadius: BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: Colorize.errorColor),
          borderRadius: BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        fillColor: Colorize.backgroundColor,
        filled: true,
        errorStyle: TextStyle(
          height: 0,
        ),
        labelStyle: TextStyle(
          color: Colorize.primaryColor,
          fontSize: 12.0,
        ),
        counterStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 4.0,
        ),
        focusColor: Colorize.accentColor,
      );

  ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(135, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          elevation: 0,
        ),
      );
}
