part of common.components;

class LightTheme {
  static double kBorderWith = 1.2 * Fonts.instance.fontScale;
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        fontFamily: kDefaultFont,
        brightness: Brightness.light,
        colorScheme: Colorize.lightColorScheme,
        iconTheme: iconTheme,
        appBarTheme: appBarTheme,
        textTheme: textTheme,
        elevatedButtonTheme: elevatedButtonThemeData,
        inputDecorationTheme: inputDecorationTheme,
        checkboxTheme: checkboxTheme,
      );

  static TextStyle get textStyle => const TextStyle(fontFamily: kDefaultFont);

  static final appBarTheme = AppBarTheme(
    color: Colorize.lightColorScheme.background,
    elevation: 5.0,
    shadowColor: Colorize.lightColorScheme.shadow,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );

  static final iconTheme = IconThemeData(
    color: Colorize.lightColorScheme.onBackground,
    size: 24 * Fonts.instance.fontScale,
  );

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
        constraints: BoxConstraints(minHeight: 50 * Fonts.instance.fontScale),
        contentPadding:
            EdgeInsets.all((kPadding / 3) * Fonts.instance.fontScale),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: kBorderWith, color: Colorize.lightColorScheme.secondary),
          borderRadius: const BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: kBorderWith, color: Colorize.lightColorScheme.error),
          borderRadius: const BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              width: kBorderWith, color: Colorize.lightColorScheme.primary),
          borderRadius: const BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: kBorderWith, color: Colorize.lightColorScheme.primary),
          borderRadius: const BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: kBorderWith, color: Colorize.lightColorScheme.error),
          borderRadius: const BorderRadius.all(
            Radius.circular(kBorderRadius),
          ),
        ),
        fillColor: Colorize.lightColorScheme.background,
        filled: true,
        errorStyle: const TextStyle(
          height: 0,
        ),
        labelStyle: TextStyle(
          color: Colorize.lightColorScheme.primary,
        ),
        counterStyle: const TextStyle(
          color: Colors.transparent,
          fontSize: 4.0,
        ),
        focusColor: Colorize.lightColorScheme.secondary,
      );

  static ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colorize.lightColorScheme.onPrimary,
          backgroundColor: Colorize.lightColorScheme.primary,
          disabledForegroundColor:
              Colorize.lightColorScheme.onSurface.withOpacity(0.38),
          disabledBackgroundColor:
              Colorize.lightColorScheme.onSurface.withOpacity(0.12),
          shadowColor: Colorize.lightColorScheme.shadow,
          surfaceTintColor: Colorize.lightColorScheme.surfaceTint,
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
        fillColor: MaterialStateProperty.all(Colorize.lightColorScheme.primary),
        checkColor:
            MaterialStateProperty.all(Colorize.lightColorScheme.onPrimary),
        side: BorderSide(
            width: kBorderWith,
            color: Colorize.lightColorScheme.secondary,
            style: BorderStyle.solid),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(kBorderRadius))), // Rounded Checkbox
      );
}
