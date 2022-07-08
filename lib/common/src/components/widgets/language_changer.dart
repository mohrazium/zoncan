import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zoncan/localization/localization.dart';
import 'package:zoncan/settings/settings.dart' show SettingsProvider;

class LanguageChanger extends StatefulWidget {
  const LanguageChanger({Key? key}) : super(key: key);

  @override
  State<LanguageChanger> createState() => _LanguageChangerState();
}

class _LanguageChangerState extends State<LanguageChanger> {
  Image _loadSelectedLanguageFlag(String languageCode) => Image.asset(
        "assets/images/flag_$languageCode.png",
        fit: BoxFit.fill,
        width: 26,
        height: 26,
      );

  void changeLanguageTo(String languageCode, BuildContext ctx) {
    LocaleSettings.setLocaleRaw(languageCode);
    Modular.get<SettingsProvider>().saveLocalSettings(languageCode).then(
        (value) =>
            BotToast.showText(text: Translations.of(ctx).languageChanged));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var translator = Translations.of(context);
      return PopupMenuButton<Locale>(
        splashRadius: 30,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onSelected: (Locale value) {
          changeLanguageTo(value.languageCode, context);
        },
        itemBuilder: (BuildContext context) {
          return LocaleSettings.supportedLocales
              .map<PopupMenuItem<Locale>>((value) {
            return PopupMenuItem(
                value: value,
                child: Row(
                  children: [
                    _loadSelectedLanguageFlag(value.languageCode),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(value.languageCode == "fa" ? "فارسی" : "English"),
                  ],
                ));
          }).toList();
        },
        child: Material(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                _loadSelectedLanguageFlag(translator.languageCode),
                const SizedBox(
                  width: 10,
                ),
                Text(translator.languageName),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
