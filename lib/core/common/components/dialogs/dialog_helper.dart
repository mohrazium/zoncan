import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:zoncan/config/config.dart';

import '../themes/fonts.dart';
import '../widgets/group_box.dart';
import 'dialog_props.dart';

typedef DialogButtonLabels =
    ({
      String lableOk,
      String lableCancel,
      String lableYes,
      String lableNo,
      String lableAccept,
    });

class DialogHelper {

 static void showLoading({
    required BuildContext context,
    String? loadingMessage,
  }) => showDialog(
    context: context,
    barrierDismissible: false, // User cannot dismiss by tapping outside
    builder: (BuildContext dialogContext) {
      final stText = StreamController<String>();
      stText.add(loadingMessage ?? "Loading...");
      // Use dialogContext to avoid issues if the main context changes
      final oSize = MediaQuery.of(dialogContext).size * Fonts.instance.fontScale;
      final double maxWidth = oSize.width >= 250 ? 250 : oSize.width * 0.8;
      final double maxHeight = oSize.height >= 250 ? 200 : oSize.height * 0.8;

      return Material(
        color: Theme.of(context).colorScheme.shadow.withAlpha(150),
        child: Center(
          child: GroupBox(
            width: maxWidth,
            height: maxHeight,
            padding: const EdgeInsets.all(kPadding),
            margin: const EdgeInsets.all(kMargin),
            color: Theme.of(context).cardColor,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: kSpacing),
                  Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: LoadingAnimationWidget.discreteCircle(
                      color: Theme.of(context).colorScheme.primary,
                      secondRingColor: Theme.of(context).colorScheme.secondary,
                      thirdRingColor: Theme.of(context).colorScheme.tertiary,
                      size: 50 * Fonts.instance.fontScale,
                    ),
                  ),
                  const SizedBox(height: kSpacing),
                  StreamBuilder(
                    stream: stText.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(kPadding),
                          child: Text(
                            snapshot.data as String,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );

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
                    style: Theme.of(context).textTheme.headlineSmall,
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
                _chooseButtons(
                  DialogProps.dialogButtonLabels,
                  dialogButtons,
                  context,
                ),
              ],
            ),
          ),
        );
      },
    );
    return (action != null) ? action : DialogResult.OK;
  }

  static Widget _chooseButtons(
    DialogButtonLabels? dialogButtonLabels,
    DialogButtons buttons,
    BuildContext context,
  ) {
    DialogButtonLabels dButtonLabels;
    if (dialogButtonLabels != null) {
      dButtonLabels = dialogButtonLabels;
    } else {
      dButtonLabels = (
        lableAccept: "Accept",
        lableCancel: "Cancel",
        lableNo: "No",
        lableOk: "Ok",
        lableYes: "Yes",
      );
    }
    switch (buttons) {
      case DialogButtons.OK:
        return Padding(
          padding: const EdgeInsets.all(kPadding),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(DialogResult.OK),
            child: Text(dButtonLabels.lableOk),
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
                child: Text(dButtonLabels.lableAccept),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kPadding),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onError,
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () => Navigator.of(context).pop(DialogResult.CANCEL),
                child: Text(dButtonLabels.lableCancel),
              ),
            ),
          ],
        );
      case DialogButtons.YES_NO:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(DialogResult.YES),
              child: Text(dButtonLabels.lableYes),
            ),
            const SizedBox(width: kSpacing),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () => Navigator.of(context).pop(DialogResult.NO),
              child: Text(dButtonLabels.lableNo),
            ),
          ],
        );
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
    DialogButtonLabels? dialogButtonLabels,
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
      title: Text(title, style: Fonts.instance.headline6()),
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
              borderRadius: const BorderRadius.all(
                Radius.circular(kBorderRadius),
              ),
              child: Scaffold(
                appBar: header,
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    kPadding,
                    0,
                    kPadding,
                    kPadding,
                  ),
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
                                  child: child,
                                ),
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
                              ? _chooseButtons(
                                dialogButtonLabels,
                                dialogButtons,
                                context,
                              )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    return (action != null) ? action : DialogResult.OK;
  }

  static void showCrashReport(
    BuildContext context,
    dynamic logger, [
    String? title,
    String? error,
  ]) {
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
