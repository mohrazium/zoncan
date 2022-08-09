part of zoncan.app;

class Application {
  Application.run() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(EntryPoint.to().app);
  }
}
