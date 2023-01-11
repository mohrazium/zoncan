part of zoncan.app;

class Application {
  static Application instance = Application();
  Application();

  void run() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(EntryPoint.to().app);
  }
}
