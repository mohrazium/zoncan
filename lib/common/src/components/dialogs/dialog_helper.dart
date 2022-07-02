import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:zoncan/constants/constants.dart';

import '../themes/colorize.dart';
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
    switch (buttons) {
      case DialogButtons.OK:
        return Padding(
          padding: const EdgeInsets.all(kPadding),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(DialogResult.OK),
            child: const Text("باشه"),
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
                  style: ElevatedButton.styleFrom(
                    primary: Colorize.accentColor,
                  ),
                  onPressed: () => Navigator.of(context).pop(DialogResult.OK),
                  child: const Text("تایید"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kPadding),
                child: ElevatedButton(
                  // textStyle: Themizer.textStyle,
                  style: ElevatedButton.styleFrom(
                    primary: Colorize.errorColor,
                  ),
                  onPressed: () => Navigator.of(context).pop(DialogResult.CANCEL),
                  child: const Text("لغو"),
                ),
              ),
            ]);
      case DialogButtons.YES_NO:
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                // textStyle: Themizer.textStyle,
                onPressed: () => Navigator.of(context).pop(DialogResult.YES),
                style: ElevatedButton.styleFrom(
                  primary: Colorize.accentColor,
                  onPrimary: Colorize.foregroundColorShade500,
                ),
                child: const Text("بله"),
              ),
              const SizedBox(width: kSpacing),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colorize.foregroundColorShade200,
                  onPrimary: Colorize.foregroundColorShade500,
                ),
                onPressed: () => Navigator.of(context).pop(DialogResult.NO),
                child: const Text("خیر"),
              ),
            ]);
      default:
        return Container();
    }
  }

  static String _chooseAssets(DialogType type) {
    switch (type) {
      case DialogType.ERROR:
        return "assets/images/error.png";
      case DialogType.INFO:
        return "assets/images/info.png";
      case DialogType.WARNING:
        return "assets/images/warning.png";
      case DialogType.SUCCESSFULLY:
        return "assets/images/success.png";
      case DialogType.FAILURE:
        return "assets/images/failure.png";

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
      iconTheme: const IconThemeData(color: Colorize.foregroundColor),
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
                  borderRadius: const BorderRadius.all(Radius.circular(kBorderRadius)),
                  child: Scaffold(
                      appBar: header,
                      body: Padding(
                        padding: const EdgeInsets.fromLTRB(kPadding, 0, kPadding, kPadding),
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
                                        Container(color: Colors.transparent, child: child)
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
                          color: Colorize.primaryColor,
                          secondRingColor: Colorize.accentColor,
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
