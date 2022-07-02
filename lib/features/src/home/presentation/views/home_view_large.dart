import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zoncan/common/common.dart';
import 'package:zoncan/common/src/components/dialogs/dialog_props.dart';
import 'package:zoncan/localization/localization.dart';

class HomeViewLarge extends StatelessWidget {
  const HomeViewLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var translator = Translations.of(context);
      return Scaffold(
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                },
                child: Text(translator.save)),
            Center(
              child: Text(translator.login.success),
            ),
          ],
        ),
      );
    });
  }
}
