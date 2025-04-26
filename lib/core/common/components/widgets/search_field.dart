import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zoncan/config/config.dart';

import '../themes/fonts.dart';
import 'text_box.dart';

class SearchField extends StatelessWidget {
  const SearchField({this.controller, this.onSearch, super.key});

  final TextEditingController? controller;
  final Function(String value)? onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: kPadding * Fonts.instance.fontScale - 5),
      child: TextBox(
        width: double.maxFinite,
        height: 55 * Fonts.instance.fontScale,
        controller: controller,
        prefixIcon: Icon(EvaIcons.search, size: 16 * Fonts.instance.fontScale),
        hintText: TranslationsProvider.translator.search,
        onChanged: onSearch,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
