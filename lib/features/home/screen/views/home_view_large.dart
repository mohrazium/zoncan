part of zoncan.features.home;

class HomeViewLarge extends StatelessWidget {
  const HomeViewLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var translator = Translations.of(context);
      final app = Modular.get<AppStateController>();

      return Scaffold(
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  app.saveFontScale(1.5);
                },
                child: Text("set to 1.5")),
            ElevatedButton(
                onPressed: () async {
                  app.saveFontScale(1.0);
                },
                child: Text("set to 1.0")),
            ElevatedButton(
                onPressed: () async {
                  final auth = Modular.get<AuthService>();
                  await auth.auditor.then((value) async {
                    print(value.currentUserId);
                    print(await value.findAll());
                  });
                },
                child: Text("Audit")),
            ElevatedButton(
                onPressed: () async {
                  app.saveFontScale(0.8);
                },
                child: Text("set to 0.8")),
            ElevatedButton(
                onPressed: () async {
                  Modular.get<AuthService>().logout();
                  Modular.to.navigate(Routing.to.splash.path,arguments: 100);
                },
                child: Text("Logout")),
            Center(
              child: Text(translator.login.login),
            ),
          ],
        ),
      );
    });
  }
}
