part of '../app.dart';

class Application {
  static Application instance = Application();

  Application();

  void run() async {
    WidgetsFlutterBinding.ensureInitialized();
    Injection.dependencyConfigurations();
    runApp(EntryPoint.launch.app);
  }
}
