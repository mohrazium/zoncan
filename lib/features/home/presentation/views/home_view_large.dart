part of '../presentation.dart';

class HomeViewLarge extends StatelessWidget {
  final Widget child;

  const HomeViewLarge({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var translator = Translations.of(context);
      return Scaffold(
        // body: Column(
        //   children: [
        //     ElevatedButton(
        //         onPressed: () async {}, child: Text(translator.save)),
        //     Center(
        //       child: Text(translator.login.login),
        //     ),
        //   ],
        // ),
        body: child,
      );
    });
  }
}
