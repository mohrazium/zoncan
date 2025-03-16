part of '../presentation.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  const HomePage({super.key, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Injection.serviceLocator<HomeController>();

  @override
  void didChangeDependencies() {
    controller.didChangeDependencies();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    controller.initState();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (BuildContext context) {
        // ignore: always_specify_types
        var translator = TranslationsProvider.translator;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
            title: Row(
              children: <Widget>[
                const LanguageChanger(),
                const Icon(Icons.more_vert),
                Expanded(child: Container()),
                ToolbarIconButton(
                  onTap: () async {
                    await controller.logoutUser();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                Stack(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.deepPurpleAccent.withOpacity(.7),
                        ),
                        onPressed: () {}),
                    Positioned(
                      top: 7,
                      right: 7,
                      child: Container(
                        width: 12,
                        height: 12,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Colors.lightBlueAccent, width: 2)),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 1,
                  height: 22,
                  color: Colors.blueGrey,
                ),
                const SizedBox(
                  width: 24,
                ),
                Observer(
                  builder: (_) => Text(
                    translator.welcome(
                        fullName: controller.currentUserNickName ?? ""),
                    style: const TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(.5),
                      borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(2),
                    child: const CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.deepPurpleAccent.withOpacity(.7),
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.deepPurpleAccent.withOpacity(.7),
                  ),
                  onPressed: () {}),
            ],
            iconTheme: const IconThemeData(color: Colors.blueGrey),
            elevation: 0,
            backgroundColor: Colors.amber,
          ),
          body: HomeViewLarge(
            child: widget.child,
          ),
        );
      }),
    );

    // return HomeView();
  }
}
