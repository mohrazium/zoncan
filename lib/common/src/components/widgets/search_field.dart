import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zoncan/constants/constants.dart' show kPadding;
import 'package:zoncan/localization/localization.dart';
import 'text_box.dart';

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
    var translator = Translations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: kPadding - 5),
      child: TextBox(
        width: double.maxFinite,
        height: 55,
        controller: controller,
        prefixIcon: const Icon(EvaIcons.search),
        hintText: translator.search,
        onChanged: onSearch,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
