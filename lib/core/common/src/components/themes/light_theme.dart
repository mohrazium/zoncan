part of '../components.dart';

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
    color: Colorize.lightColorScheme.surface,
    elevation: 5.0,
    shadowColor: Colorize.lightColorScheme.shadow,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );

  static final iconTheme = IconThemeData(
    color: Colorize.lightColorScheme.onSurface,
    size: 24 * Fonts.instance.fontScale,
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
      bodySmall: Fonts.instance.caption());

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
        fillColor: Colorize.lightColorScheme.surface,
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
        fillColor: WidgetStateProperty.all(Colorize.lightColorScheme.primary),
        checkColor:
            WidgetStateProperty.all(Colorize.lightColorScheme.onPrimary),
        side: BorderSide(
            width: kBorderWith,
            color: Colorize.lightColorScheme.secondary,
            style: BorderStyle.solid),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(kBorderRadius))), // Rounded Checkbox
      );
}
