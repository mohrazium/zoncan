part of common.components;

class TextBox extends StatefulWidget {
  final String? titleText;
  final String? hintText;
  final Icon? icon;
  final int? maxLines;
  final TextEditingController? controller;
  final double? width;
  final double? height;
  final bool isSecure;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Icon? suffixIcon;
  final Widget? suffixWidget;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final int maxLength;
  final bool readOnly;
  final bool enabled;
  final FormFieldSetter<String>? onSaved;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool isRequired;
  final String? errorText;
  final bool autofocus;

  const TextBox({
    Key? key,
    this.titleText,
    this.hintText,
    this.icon,
    this.maxLines,
    this.controller,
    this.width = double.maxFinite,
    this.height = 50,
    this.isSecure = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.maxLength = 255,
    this.readOnly = false,
    this.enabled = true,
    this.onSaved,
    this.onEditingComplete,
    this.textInputAction,
    this.inputFormatters,
    this.isRequired = false,
    this.errorText,
    this.suffixWidget, this.autofocus=false,
  }) : super(key: key);

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  late Icon _textFieldIcon = const Icon(Icons.text_fields);
  bool _isShowPassword = false;

  getPasswordIconState() {
    if (widget.isSecure) {
      _textFieldIcon = _isShowPassword
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility);
    } else if (widget.suffixIcon != null) {
      _textFieldIcon = widget.suffixIcon!;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? formatter = [
      LengthLimitingTextInputFormatter(widget.maxLength),
    ];

    if (widget.keyboardType != null) {
      formatter.add(widget.keyboardType == TextInputType.number
          ? FilteringTextInputFormatter.digitsOnly
          : FilteringTextInputFormatter.singleLineFormatter);
    }

    formatter.addAll(widget.inputFormatters ?? []);
    getPasswordIconState();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        widget.titleText != null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kPadding / 3, horizontal: kPadding / 2),
                child: Row(
                  children: [
                    Text(
                      widget.titleText ?? "",
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Text(
                      widget.isRequired ? "*" : "",
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ],
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding / 3),
          child: SizedBox(
            width: widget.width,
            child: TextFormField(
              autofocus: widget.autofocus,
              textInputAction: widget.textInputAction,
              readOnly: widget.readOnly,
              enabled: widget.enabled,
              onSaved: widget.onSaved,
              onEditingComplete: widget.onEditingComplete,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorRadius: const Radius.circular(kBorderRadius * 10),
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              inputFormatters: formatter,
              obscureText: widget.isSecure ? !_isShowPassword : false,
              controller: widget.controller,
              validator: widget.validator,
              onChanged: widget.onChanged,
              decoration: _getInputDecoration(),
              maxLines: widget.isSecure ? 1 : widget.maxLines,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.start,
              obscuringCharacter: "✺",
            ),
          ),
        ),
      ],
    );
  }

  _getInputDecoration() {
    return InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(kPadding * 0.8),
        hintText: widget.hintText,
        icon: widget.icon,
        errorText: widget.errorText,
        errorMaxLines: 1,
        prefixIcon: !widget.readOnly ? widget.prefixIcon : null,
        suffixIcon: widget.isSecure
            ? IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: _textFieldIcon,
                onPressed: widget.readOnly
                    ? null
                    : () {
                        setState(() {
                          _isShowPassword = !_isShowPassword;
                        });
                      },
              )
            : widget.suffixIcon ?? widget.suffixWidget);
  }
}
