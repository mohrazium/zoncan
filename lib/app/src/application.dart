

import 'package:flutter/material.dart';
import 'package:zoncan/config/config.dart';

import 'zoncan.dart';

class Application {
  static Application instance = Application();

  late final ZRouter zRouter;

  Application();

  void run() async {
    WidgetsFlutterBinding.ensureInitialized();
    Injection.dependencyConfigurations();
    zRouter = Injection.serviceLocator.get<ZRouter>();
    zRouter.setupRouter();

      runApp(TranslationProvider(child: const Zoncan()));
  }
}