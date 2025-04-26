// ignore_for_file: constant_identifier_names

import 'package:zoncan/config/config.dart';

import 'dialog_helper.dart';

enum DialogType { INFO, WARNING, ERROR, SUCCESSFULLY, FAILURE }

enum DialogButtons { YES_NO, OK, OK_CANCEL }

enum DialogResult { YES, NO, OK, CANCEL, IGNORE }

class DialogProps {
  static DialogButtonLabels get dialogButtonLabels => (
        lableYes: TranslationsProvider.translator.yes,
        lableNo: TranslationsProvider.translator.no,
        lableCancel: TranslationsProvider.translator.cancel,
        lableOk: TranslationsProvider.translator.ok,
        lableAccept: TranslationsProvider.translator.accept,
      );
}
