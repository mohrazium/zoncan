
import 'package:floy/floy.dart';
import 'package:flutter/material.dart';
import 'package:zoncan/features/home/presentation/views/first_setup_view.dart';

class FirstSetupPage extends StatefulWidget {
  const FirstSetupPage({super.key});

  @override
  State<FirstSetupPage> createState() => _FirstSetupPageState();
}

class _FirstSetupPageState extends State<FirstSetupPage> {
  @override
  Widget build(BuildContext context) {
    return const FirstSetupView();
  }
}

class FirstSetupPageWindowed extends FloyWindow {
  final BuildContext context;
  FirstSetupPageWindowed(this.context, {super.key});

  @override
  _SetupWindowState createState() => _SetupWindowState();

  @override
  FloyWindowProperties get properties => FloyWindowProperties(
        title: "title",
        initialWidth: 600,
        initialHeight: 500,
        context: context,
      );
}

class _SetupWindowState extends FloyWindowState {
  @override
  Widget buildWindow() {
    return const FirstSetupPage();
  }
}
