import 'package:flutter/material.dart';
import 'package:zoncan/common/src/components/themes/themes.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

class Themizer {
  Themizer._();

  static ThemeData get theme => ThemeData(colorSchemeSeed: Colorize.seed);
  static ThemeData get light => LightTheme.theme;
  static ThemeData get dark => DarkTheme.theme;
}
