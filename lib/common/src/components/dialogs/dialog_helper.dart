import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:zoncan/constants/constants.dart';
import 'package:zoncan/localization/localization.dart';

import '../themes/fonts.dart';
import '../widgets/group_box.dart';
import 'dialog_props.dart';

class DialogHelper {
  static Future<DialogResult> showMessageBox({
    required BuildContext context,
    required String title,
    required String message,
    required DialogType dialogType,
    required DialogButtons dialogButtons,
  }) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  _chooseAssets(dialogType),
                  height: 64.0,
                  width: 64.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: kSpacing),
                _chooseButtons(dialogButtons, context)
              ],
            ),
          ),
        );
      },
    );
    return (action != null) ? action : DialogResult.OK;
  }

  static Widget _chooseButtons(DialogButtons buttons, BuildContext context) {
    var translator = Translations.of(context);

    switch (buttons) {
      case DialogButtons.OK:
        return Padding(
          padding: const EdgeInsets.all(kPadding),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(DialogResult.OK),
            child: Text(translator.ok),
          ),
        );
      case DialogButtons.OK_CANCEL:
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(kPadding),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(DialogResult.OK),
                  child: Text(translator.accept),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kPadding),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.error,
                    onPrimary: Theme.of(context).colorScheme.onError,
                  ),
                  onPressed: () =>
                      Navigator.of(context).pop(DialogResult.CANCEL),
                  child: Text(translator.cancel),
                ),
              ),
            ]);
      case DialogButtons.YES_NO:
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(DialogResult.YES),
                child: Text(translator.yes),
              ),
              const SizedBox(width: kSpacing),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  onPrimary: Theme.of(context).colorScheme.onSecondary,
                ),
                onPressed: () => Navigator.of(context).pop(DialogResult.NO),
                child: Text(translator.no),
              ),
            ]);
      default:
        return Container();
    }
  }

  static String _chooseAssets(DialogType type) {
    switch (type) {
      case DialogType.ERROR:
        return Assets.icons.errorPNG;
      case DialogType.INFO:
        return Assets.icons.infoPNG;
      case DialogType.WARNING:
        return Assets.icons.warningPNG;
      case DialogType.SUCCESSFULLY:
        return Assets.icons.successPNG;
      case DialogType.FAILURE:
        return Assets.icons.failurePNG;

      default:
        return "";
    }
  }

  static Future<DialogResult> show({
    required BuildContext context,
    required String title,
    double? width,
    double? height,
    bool alwaysOpen = false,
    bool isScrollable = false,
    DialogButtons? dialogButtons,
    Widget? child,
  }) async {
    final header = AppBar(
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.surface),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(DialogResult.IGNORE),
        icon: const Icon(EvaIcons.close),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: Fonts.headline6(),
      ),
      elevation: 0.0,
    );
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: SizedBox(
                width: width,
                height: height,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(kBorderRadius)),
                  child: Scaffold(
                      appBar: header,
                      body: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            kPadding, 0, kPadding, kPadding),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            child != null
                                ? Expanded(
                                    child: ListView(
                                      shrinkWrap: true,
                                      controller: ScrollController(),
                                      children: [
                                        Container(
                                            color: Colors.transparent,
                                            child: child)
                                      ],
                                    ),
                                  )
                                : Container(),
                            const SizedBox(height: kSpacing / 3),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  dialogButtons != null
                                      ? _chooseButtons(dialogButtons, context)
                                      : Container()
                                ])
                          ],
                        ),
                      )),
                )),
          );
        });

    return (action != null) ? action : DialogResult.OK;
  }

  static bool _isShowDialog = false;

  static void showLoading(BuildContext context, [String? title]) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.grey.withOpacity(.1),
        builder: (BuildContext context) {
          _isShowDialog = true;
          return Dialog(
            backgroundColor: Colors.transparent,
            child: GroupBox(
              height: 200,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                      child: LoadingAnimationWidget.discreteCircle(
                          color: Theme.of(context).colorScheme.primary,
                          secondRingColor:
                              Theme.of(context).colorScheme.secondary,
                          thirdRingColor:
                              Theme.of(context).colorScheme.tertiary,
                          size: 65)),
                  const SizedBox(
                    height: kSpacing,
                  ),
                  Center(
                      child: Text(
                    title ?? "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ))
                ],
              ),
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    if (_isShowDialog) {
      Future.delayed(const Duration(milliseconds: 250)).whenComplete(() {
        _isShowDialog = false;
        Navigator.of(context).pop(DialogResult.IGNORE);
      });
    }
  }

  static void showCrashReport(BuildContext context, dynamic logger,
      [String? title, String? error]) {
    logger.error(error ?? "");
    show(
      context: context,
      isScrollable: true,
      title: title ?? "",
      child: Text(
        error ?? "",
        textAlign: TextAlign.left,
        maxLines: 1000,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
