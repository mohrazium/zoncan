
import 'package:flutter/material.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/config/src/localization/languages/strings.g.dart';

import '../themes/fonts.dart';

class LanguageChanger extends StatefulWidget {
  const LanguageChanger({super.key});

  @override
  State<LanguageChanger> createState() => _LanguageChangerState();
}

class _LanguageChangerState extends State<LanguageChanger> {
  Image _loadSelectedLanguageFlag(String languageCode) => Image.asset(
        "assets/icons/flag_$languageCode.png",
        fit: BoxFit.fill,
        width: 13 * Fonts.instance.fontScale,
        height: 13 * Fonts.instance.fontScale,
      );

  Future<void> changeLanguageTo(String languageCode, BuildContext ctx) async {
    await Injection.serviceLocator.get<SettingsProvider>().saveLocale(languageCode);
    LocaleSettings.setLocaleRaw(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var translator = TranslationsProvider.translator;
      return ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: PopupMenuButton<String>(
          splashRadius: kBorderRadius,
          color: Theme.of(context).colorScheme.surface,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          onSelected: (String languageCode) {
            changeLanguageTo(languageCode, context);
          },
          itemBuilder: (BuildContext context) {
            return AppLocale.values
                .map<PopupMenuItem<String>>((applocale) {
              return PopupMenuItem(
                  value: applocale.languageCode,
                  height: 25 * Fonts.instance.fontScale,
                  child: Row(
                    children: [
                      _loadSelectedLanguageFlag(applocale.languageCode),
                      SizedBox(
                        width: 5 * Fonts.instance.fontScale,
                      ),
                      Text(applocale.languageCode == "fa" ? "فارسی" : "English"),
                    ],
                  ));
            }).toList();
          },
          child: Material(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(kBorderRadius),
            borderOnForeground: false,
            child: Padding(
              padding: const EdgeInsets.all(kPadding),
              child: Row(
                children: [
                  _loadSelectedLanguageFlag(translator.languageCode),
                  SizedBox(
                    width: 5 * Fonts.instance.fontScale,
                  ),
                  Text(translator.languageName),
                  SizedBox(
                    width: 5 * Fonts.instance.fontScale,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 5 * Fonts.instance.fontScale,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
