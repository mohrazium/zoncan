part of common.components;

class FormCard extends StatelessWidget with DateConverterMixin {
  final Key? globalFormKey;
  final bool readyOnly;
  final Function() onConfirmButtonPressed;
  final Function() onCancelButtonPressed;
  final double? maxWidth;
  final double? minWidth;
  final double? maxHeight;
  final double? minHeight;
  final Color? color;
  final Color? headerColor;
  final Widget headerContent;
  final Widget child;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool haveShadow;
  final Widget? footerChild;

  const FormCard({
    Key? key,
    this.globalFormKey,
    required this.readyOnly,
    required this.onConfirmButtonPressed,
    required this.onCancelButtonPressed,
    this.maxWidth = 200,
    this.minWidth,
    this.maxHeight,
    this.minHeight,
    this.color,
    this.headerColor,
    required this.headerContent,
    required this.child,
    this.createdAt,
    this.updatedAt,
    this.haveShadow = false,
    this.footerChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: headerColor ?? Theme.of(context).colorScheme.primary,
                child: Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: headerContent),
              ),
              Padding(padding: const EdgeInsets.all(kPadding), child: child),
            ],
          ),
          _buildFooter(context, footerChild),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, Widget? footerChild) {
    Widget buildConfirmButton() {
      return ElevatedButton.icon(
        icon: Icon(
          readyOnly ? EvaIcons.edit : EvaIcons.checkmark,
          size: 24 * Fonts.instance.fontScale,
        ),
        onPressed: () => onConfirmButtonPressed(),
        label: Text(readyOnly ? t.edit : t.accept),
      );
    }

    Widget buildCancelButton(BuildContext context) {
      return ElevatedButton(
        onPressed: readyOnly ? null : () => onCancelButtonPressed(),
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onTertiary,
          backgroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        child: Text(t.cancel),
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
                    ? "${t.createdAt}: ${toShamsi(createdAt)}"
                    : "",
                style: Themizer.light.textTheme.caption,
              ),
              Text(
                updatedAt != null
                    ? "${t.updatedAt}: ${toShamsi(updatedAt)}"
                    : "",
                style: Themizer.light.textTheme.caption,
              ),
            ],
          ),
          Row(
            children: [
              footerChild ?? Container(),
              const SizedBox(
                width: kSpacing / 2,
              ),
              buildConfirmButton(),
              const SizedBox(
                width: kSpacing / 2,
              ),
              buildCancelButton(context)
            ],
          ),
        ],
      ),
    );
  }
}
