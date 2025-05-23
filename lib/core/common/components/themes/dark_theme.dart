import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show Brightness, Size, SystemUiOverlayStyle;
import 'package:zoncan/config/config.dart';

import 'colorize.dart';
import 'fonts.dart';

class DarkTheme {
  static double kBorderWith = 1.2 * Fonts.instance.fontScale;
  static ThemeData get theme => ThemeData(
    colorSchemeSeed: Colorize.seed,
    useMaterial3: true,
    fontFamily: kDefaultFont,
    brightness: Brightness.dark,
  //  colorScheme: Colorize.darkColorScheme,
    iconTheme: iconTheme,
    appBarTheme: appBarTheme,
    textTheme: textTheme,
    elevatedButtonTheme: elevatedButtonThemeData,
    inputDecorationTheme: inputDecorationTheme,
    checkboxTheme: checkboxTheme,
  );

  static TextStyle get textStyle => const TextStyle(fontFamily: kDefaultFont);

  static final appBarTheme = AppBarTheme(
    color: Colorize.darkColorScheme.surface,
    elevation: 5.0 * Fonts.instance.fontScale,
    shadowColor: Colorize.darkColorScheme.shadow,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );

  static final iconTheme = IconThemeData(
    color: Colorize.darkColorScheme.onSurface,
  );

  static TextTheme get textTheme => TextTheme(
    displayLarge: Fonts.instance.headline1(),
    displayMedium: Fonts.instance.headline2(),
    displaySmall: Fonts.instance.headline3(),
    headlineMedium: Fonts.instance.headline4(),
    headlineSmall: Fonts.instance.headline5(),
    titleLarge: Fonts.instance.headline6(),
    bodyLarge: Fonts.instance.body1(),
    bodyMedium: Fonts.instance.body2(),
    titleMedium: Fonts.instance.subtitle1(),
    titleSmall: Fonts.instance.subtitle2(),
    bodySmall: Fonts.instance.caption(),
  );

  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    contentPadding: EdgeInsets.all((kPadding / 3) * Fonts.instance.fontScale),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: kBorderWith,
        color: Colorize.darkColorScheme.secondary,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(kBorderRadius)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: kBorderWith,
        color: Colorize.darkColorScheme.error,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(kBorderRadius)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        width: kBorderWith,
        color: Colorize.darkColorScheme.primary,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(kBorderRadius)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: kBorderWith,
        color: Colorize.darkColorScheme.primary,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(kBorderRadius)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: kBorderWith,
        color: Colorize.darkColorScheme.error,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(kBorderRadius)),
    ),
    fillColor: Colorize.darkColorScheme.surface,
    filled: true,
    errorStyle: const TextStyle(height: 0),
    labelStyle: TextStyle(color: Colorize.darkColorScheme.primary),
    counterStyle: const TextStyle(color: Colors.transparent, fontSize: 4.0),
    focusColor: Colorize.darkColorScheme.secondary,
  );

  static ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colorize.darkColorScheme.onPrimary,
          backgroundColor: Colorize.darkColorScheme.primary,
          disabledForegroundColor: Colorize.darkColorScheme.onSurface
              .withOpacity(0.38),
          disabledBackgroundColor: Colorize.darkColorScheme.onSurface
              .withOpacity(0.12),
          shadowColor: Colorize.darkColorScheme.shadow,
          surfaceTintColor: Colorize.darkColorScheme.surfaceTint,
          elevation: 0.0,
          fixedSize: Size(
            135 * Fonts.instance.fontScale,
            40 * Fonts.instance.fontScale,
          ),
          animationDuration: kAnimationDuration,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          textStyle: Fonts.instance.button(),
        ),
      );

  static CheckboxThemeData get checkboxTheme => CheckboxThemeData(
    fillColor: WidgetStateProperty.all(Colorize.darkColorScheme.primary),
    checkColor: WidgetStateProperty.all(Colorize.darkColorScheme.onPrimary),
    side: BorderSide(
      width: kBorderWith,
      color: Colorize.darkColorScheme.secondary,
      style: BorderStyle.solid,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
    ), // Rounded Checkbox
  );
}
