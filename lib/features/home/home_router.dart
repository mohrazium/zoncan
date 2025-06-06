library;

import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/security/security.dart';
import 'package:zoncan/features/home/presentation/pages/dashboard_page.dart';
import 'package:zoncan/features/home/presentation/pages/home_page.dart';
import 'package:zoncan/features/wizard/presentation/controllers/wizard_middleware.dart';

class HomeRouetr {
  static HomeRouetr get get => HomeRouetr();

  QRoute get routes => QRoute.withChild(
    path: Routing.to.home.path,
    name: Routing.to.home.named,
    builderChild: (router) => HomePage(child: router),
    middleware: [RequireAuthMiddleware(), WizardMiddleware()],
    initRoute: Routing.to.dashboard.path,
    children: [
      QRoute(
        path: Routing.to.dashboard.named,
        name: Routing.to.dashboard.named,
        builder: () => DashboardPage(key: Routing.to.dashboard.key),
      ),
      // QRoute(path: Routing.to.products.named, name: Routing.to.products.named, builder: () => const ProductsPage()),
    ],
  );
}
