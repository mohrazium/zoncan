library zoncan.core.config.localization;

import 'package:flutter/widgets.dart';

import 'languages/strings.g.dart';
export 'languages/strings.g.dart' show TranslationProvider,LocaleSettings;

class TranslationsProvider {
  static Iterable<Locale> get supportedLocales =>
      AppLocaleUtils.supportedLocales;

  static Translations get translator =>
      LocaleSettings.instance.currentTranslations;

  static Locale? localeOf(BuildContext context) =>
      TranslationProvider.of(context).flutterLocale;
}
