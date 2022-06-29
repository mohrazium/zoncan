import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
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
                onPressed: () {
                  var cancel =
                      BotToast.showLoading(); // popup a notification toast;
                  Future.delayed(const Duration(seconds: 5)).then((value) => cancel());
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
