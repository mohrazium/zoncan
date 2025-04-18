library zoncan.features.home;

import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/security/security.dart';

import 'presentation/presentation.dart';

export "presentation/presentation.dart";

class Home {
  static Home get get => Home();

  QRoute get routes => // --- گروه Home با پوسته HomePage ---
      QRoute.withChild(
        path: Routing.to.home.path, // مسیر پدر
        name: Routing.to.home.named, // نام پدر
        builderChild: (router) => HomePage(child: router), // پوسته
        // برای دسترسی به این بخش نیاز به احراز هویت است
        middleware: [RequireAuthMiddleware()],
        // مسیر پیش‌فرض داخل این پوسته
        initRoute: Routing.to.dashboard.path, // با مسیر کامل فرزند مشخص کنید
        children: [
          // فرزندان داخل پوسته Home
          QRoute(
            path: Routing.to.dashboard.named, // فقط نام فرزند
            name: Routing.to.dashboard.named, // نام منحصر به فرد
            builder: () => const DashboardPage(),
            pageType: const QSlidePage(transitionDuration: kAnimationDuration),
          ),
          QRoute(
            path: Routing.to.firstSetup.named,
            name: Routing.to.firstSetup.named,
            builder: () => const FirstSetupPage(),
            pageType: const QSlidePage(transitionDuration: kAnimationDuration),
          ),
          // مسیرهای دیگر Home را اینجا اضافه کنید
          // QRoute(path: Routing.to.products.named, name: Routing.to.products.named, builder: () => const ProductsPage()),
        ],
      );
}
