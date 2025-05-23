library;

import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/security/security.dart';
import 'package:zoncan/features/home/presentation/pages/dashboard_page.dart';
import 'package:zoncan/features/home/presentation/pages/first_setup_page.dart';
import 'package:zoncan/features/home/presentation/pages/home_page.dart';


class Home {
  static Home get get => Home();

  QRoute get routes =>
      QRoute.withChild(
        path: Routing.to.home.path, 
        name: Routing.to.home.named, 
        builderChild: (router) => HomePage(child: router), 
        middleware: [RequireAuthMiddleware()],
        initRoute: Routing.to.dashboard.path, 
        children: [
          QRoute(
            path: Routing.to.dashboard.named, 
            name: Routing.to.dashboard.named, 
            builder: () => const DashboardPage(),
            pageType: const QSlidePage(transitionDuration: kAnimationDuration),
          ),
          QRoute(
            path: Routing.to.firstSetup.named,
            name: Routing.to.firstSetup.named,
            builder: () => const FirstSetupPage(),
            pageType: const QSlidePage(transitionDuration: kAnimationDuration),
          ),
          // QRoute(path: Routing.to.products.named, name: Routing.to.products.named, builder: () => const ProductsPage()),
        ],
      );
}
