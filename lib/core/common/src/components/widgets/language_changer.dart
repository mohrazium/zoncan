part of '../components.dart';

class LanguageChanger extends StatefulWidget {
  const LanguageChanger({super.key});

  @override
  State<LanguageChanger> createState() => _LanguageChangerState();
}

class _LanguageChangerState extends State<LanguageChanger> {
  Image _loadSelectedLanguageFlag(String languageCode) => Image.asset(
        "assets/icons/flag_$languageCode.png",
        fit: BoxFit.fill,
        width: 26 * Fonts.instance.fontScale,
        height: 26 * Fonts.instance.fontScale,
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
        child: PopupMenuButton<Locale>(
          splashRadius: kBorderRadius,
          color: Theme.of(context).colorScheme.surface,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          onSelected: (Locale value) {
            changeLanguageTo(value.languageCode, context);
          },
          itemBuilder: (BuildContext context) {
            return LocaleSettings.instance.supportedLocales
                .map<PopupMenuItem<Locale>>((value) {
              return PopupMenuItem(
                  value: value,
                  height: 60 * Fonts.instance.fontScale,
                  child: Row(
                    children: [
                      _loadSelectedLanguageFlag(value.languageCode),
                      SizedBox(
                        width: 10 * Fonts.instance.fontScale,
                      ),
                      Text(value.languageCode == "fa" ? "فارسی" : "English"),
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
                    width: 10 * Fonts.instance.fontScale,
                  ),
                  Text(translator.languageName),
                  SizedBox(
                    width: 10 * Fonts.instance.fontScale,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 16 * Fonts.instance.fontScale,
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
