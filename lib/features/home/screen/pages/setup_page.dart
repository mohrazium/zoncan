part of zoncan.features.home;

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SetupPageWindowed extends FloyWindow {
  final BuildContext context;
  SetupPageWindowed(this.context, {super.key});

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
    return const SetupView();
  }
}
