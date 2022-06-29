
import 'package:flutter/widgets.dart';

import 'entry_point.dart';

class Application {
  Application.run() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(EntryPoint.to().app);
  }
}
