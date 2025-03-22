part of '../components.dart';

class ImageViewPersonalPic extends StatelessWidget {
  final Image image;
  final void Function()? onNewPressed;
  final void Function()? onRemovePressed;

  const ImageViewPersonalPic({
    super.key,
    required this.image,
    required this.onNewPressed,
    required this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    var translator = TranslationsProvider.translator;
    return GroupBox(
        width: kTextFieldWidth * Fonts.instance.fontScale,
        height: kTextFieldWidth * Fonts.instance.fontScale * 1.2 ,
        margin: const EdgeInsets.all(kPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            image,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize:  Size(90 * Fonts.instance.fontScale, 40 * Fonts.instance.fontScale),
                    ),
                    onPressed: onNewPressed,
                    icon: const Icon(EvaIcons.personAdd),
                    label: SizedBox(
                        width: 200 * Fonts.instance.fontScale,
                        child: Center(child: Text(translator.addNew)))),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize:  Size(90 * Fonts.instance.fontScale, 40 * Fonts.instance.fontScale),
                    ),
                    onPressed: onRemovePressed,
                    icon: const Icon(EvaIcons.personDelete),
                    label: SizedBox(
                        width: 200 * Fonts.instance.fontScale,
                        child: Center(child: Text(translator.remove)))),
              ],
            )
          ],
        ));
  }
}
