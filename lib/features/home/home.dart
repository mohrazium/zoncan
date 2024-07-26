library zoncan.features.home;

import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';

import 'presentation/presentation.dart';

export "presentation/presentation.dart";

class Home {
  static Home get get => Home();

  QRoute get routes => QRoute.withChild(
        path: Routing.to.home.path,
        builderChild: (homeContent) => HomePage(child: homeContent),
        initRoute: Routing.to.dashboard.path,
        children: [
          QRoute(
              path: Routing.to.dashboard.named,
              pageType: const QFadePage(),
              builder: () => const DashboardPage()),
        ],
      );
}
