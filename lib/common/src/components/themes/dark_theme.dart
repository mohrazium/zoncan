part of common.components;

class DarkTheme {
  static double kBorderWith = 1.2 * Fonts.instance.fontScale;
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        fontFamily: kDefaultFont,
        brightness: Brightness.dark,
        colorScheme: Colorize.darkColorScheme,
        iconTheme: iconTheme,
        appBarTheme: appBarTheme,
        textTheme: textTheme,
        elevatedButtonTheme: elevatedButtonThemeData,
        inputDecorationTheme: inputDecorationTheme,
        checkboxTheme: checkboxTheme,
      );

  static TextStyle get textStyle => const TextStyle(fontFamily: kDefaultFont);

  static final appBarTheme = AppBarTheme(
    color: Colorize.darkColorScheme.background,
    elevation: 5.0 * Fonts.instance.fontScale,
    shadowColor: Colorize.darkColorScheme.shadow,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );

  static final iconTheme =
      IconThemeData(color: Colorize.darkColorScheme.onBackground);

  static TextTheme get textTheme => TextTheme(
      headline1: Fonts.instance.headline1(),
      headline2: Fonts.instance.headline2(),
      headline3: Fonts.instance.headline3(),
      headline4: Fonts.instance.headline4(),
      headline5: Fonts.instance.headline5(),
      headline6: Fonts.instance.headline6(),
      bodyText1: Fonts.instance.body1(),
      bodyText2: Fonts.instance.body2(),
      subtitle1: Fonts.instance.subtitle1(),
      subtitle2: Fonts.instance.subtitle2(),
      caption: Fonts.instance.caption());

  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        contentPadding:
            EdgeInsets.all((kPadding / 3) * Fonts.instance.fontScale),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: kBorderWith, color: Colorize.darkColorScheme.secondary),
          borderRadius: const BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: kBorderWith, color: Colorize.darkColorScheme.error),
          borderRadius: const BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              width: kBorderWith, color: Colorize.darkColorScheme.primary),
          borderRadius: const BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: kBorderWith, color: Colorize.darkColorScheme.primary),
          borderRadius: const BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: kBorderWith, color: Colorize.darkColorScheme.error),
          borderRadius: const BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        fillColor: Colorize.darkColorScheme.background,
        filled: true,
        errorStyle: const TextStyle(
          height: 0,
        ),
        labelStyle: TextStyle(
          color: Colorize.darkColorScheme.primary,
        ),
        counterStyle: const TextStyle(
          color: Colors.transparent,
          fontSize: 4.0,
        ),
        focusColor: Colorize.darkColorScheme.secondary,
      );

  static ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colorize.darkColorScheme.onPrimary,
          backgroundColor: Colorize.darkColorScheme.primary,
          disabledForegroundColor:
              Colorize.darkColorScheme.onSurface.withOpacity(0.38),
          disabledBackgroundColor:
              Colorize.darkColorScheme.onSurface.withOpacity(0.12),
          shadowColor: Colorize.darkColorScheme.shadow,
          surfaceTintColor: Colorize.darkColorScheme.surfaceTint,
          elevation: 0.0,
          fixedSize: Size(
              135 * Fonts.instance.fontScale, 40 * Fonts.instance.fontScale),
          animationDuration: kAnimationDuration,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          textStyle: Fonts.instance.button(),
        ),
      );

  static CheckboxThemeData get checkboxTheme => CheckboxThemeData(
        fillColor: MaterialStateProperty.all(Colorize.darkColorScheme.primary),
        checkColor:
            MaterialStateProperty.all(Colorize.darkColorScheme.onPrimary),
        side: BorderSide(
            width: kBorderWith,
            color: Colorize.darkColorScheme.secondary,
            style: BorderStyle.solid),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(kBorderRadius))), // Rounded Checkbox
      );
}
