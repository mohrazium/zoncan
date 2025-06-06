import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/utils/utils.dart';

import '../themes/themizer.dart';
import 'group_box.dart';

class FormCard extends StatelessWidget with DateConverterMixin {
  final Key? globalFormKey;
  final bool readyOnly;
  final Function() onConfirmButtonPressed;
  final Function() onCancelButtonPressed;
  final double? maxWidth;
  final double? minWidth;
  final Color? color;
  final Color? headerColor;
  final Widget headerContent;
  final Widget child;
  final String saveButtonLable;
  final String cancelButtonLable;
  final String editButtonLable;
  final String createdAtLable;
  final String updatedAtLable;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool haveShadow;
  final Widget? footerChild;

  const FormCard({
    super.key,
    this.globalFormKey,
    required this.readyOnly,
    required this.onConfirmButtonPressed,
    required this.onCancelButtonPressed,
    this.maxWidth,
    this.minWidth,
    this.color,
    this.headerColor,
    required this.headerContent,
    required this.child,
    this.haveShadow = false,
    this.footerChild,
    this.createdAt,
    this.updatedAt,
    this.saveButtonLable = "Save",
    this.cancelButtonLable = "Cancel",
    this.createdAtLable = "Created At:",
    this.updatedAtLable = "Updated At:",
    this.editButtonLable = "Edit",
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: minWidth ?? 200,
              maxWidth: maxWidth ?? 520,
            ),
            child: GroupBox(
              haveShadow: haveShadow,
              color: color ?? Theme.of(context).cardTheme.color,
              child: Column(
                children: [
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            color:
                                headerColor ??
                                Theme.of(context).primaryColor.withAlpha(100),
                            child: Padding(
                              padding: const EdgeInsets.all(kPadding),
                              child: headerContent,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(kPadding),
                            child: child,
                          ),
                        ],
                      ),
                      _buildFooter(context, footerChild),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, Widget? footerChild) {
    Widget buildConfirmButton() {
      return ElevatedButton.icon(
        icon: Icon(readyOnly ? EvaIcons.edit : EvaIcons.checkmark, size: 24),
        onPressed: () => onConfirmButtonPressed(),
        label: Text(readyOnly ? editButtonLable : saveButtonLable),
      );
    }

    Widget buildCancelButton(BuildContext context) {
      return ElevatedButton(
        onPressed: readyOnly ? null : () => onCancelButtonPressed(),
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        child: Text(cancelButtonLable),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(kPadding, 0, kPadding, kPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                createdAt != null
                    ? "$createdAtLable: ${toShamsi(createdAt)}"
                    : "",
                style: Themizer.light.textTheme.bodySmall,
              ),
              Text(
                updatedAt != null
                    ? "$updatedAtLable: ${toShamsi(updatedAt)}"
                    : "",
                style: Themizer.light.textTheme.bodySmall,
              ),
            ],
          ),
          Row(
            children: [
              footerChild ?? Container(),
              const SizedBox(width: kSpacing / 2),
              buildConfirmButton(),
              const SizedBox(width: kSpacing / 2),
              buildCancelButton(context),
            ],
          ),
        ],
      ),
    );
  }
}
