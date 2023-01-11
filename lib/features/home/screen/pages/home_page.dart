part of zoncan.features.home;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppBar zoncanAppBar;
  @override
  void initState() {
    super.initState();
    zoncanAppBar = buildAppBar();
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.amber,
      title: Row(
        children: <Widget>[
          const LanguageChanger(),
          const Icon(Icons.more_vert),
          Expanded(child: Container()),
          IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.deepPurpleAccent,
              ),
              onPressed: () {
                Modular.get<FloyWindowManager>().createWindow(SetupPageWindowed(
                  context,
                  key: UniqueKey(),
                ));
              }),
          Stack(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.deepPurpleAccent.withOpacity(.7),
                  ),
                  onPressed: () {
                    Modular.get<FloyWindowManager>().closeAll();
                  }),
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
                      border:
                          Border.all(color: Colors.lightBlueAccent, width: 2)),
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
          Text(
            t.welcome(fullName: "name"),
            style: const TextStyle(
              color: Colors.blueGrey,
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
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
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
              Icons.abc_outlined,
              color: Colors.deepPurpleAccent.withOpacity(.7),
            ),
            onPressed: () {
              setState(() {});
            }),
        IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.deepPurpleAccent.withOpacity(.7),
            ),
            onPressed: () {}),
      ],
      iconTheme: const IconThemeData(color: Colors.blueGrey),
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Floy(
        windowManager: Modular.get<FloyWindowManager>(),
        appBar: zoncanAppBar,
        routerWidget: const HomeViewLarge());

    // return HomeView();
  }
}
