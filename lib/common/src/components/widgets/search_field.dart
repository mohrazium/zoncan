part of common.components;

class SearchField extends StatelessWidget {
  const SearchField({
    this.controller,
    this.onSearch,
    Key? key,
  }) : super(key: key);

  final TextEditingController? controller;
  final Function(String value)? onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: kPadding * Fonts.instance.fontScale - 5),
      child: TextBox(
        width: double.maxFinite,
        height: 55 * Fonts.instance.fontScale,
        controller: controller,
        prefixIcon:  Icon(EvaIcons.search , size: 16 * Fonts.instance.fontScale),
        hintText: t.search,
        onChanged: onSearch,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
