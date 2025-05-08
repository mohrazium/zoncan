import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final Widget child;

  const HomeView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
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
      },
    );
  }
}
