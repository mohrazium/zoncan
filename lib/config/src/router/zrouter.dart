library;

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/common/common.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';
import 'package:zoncan/features/accounts/accounts_router.dart';
import 'package:zoncan/features/home/home_router.dart';
import 'package:zoncan/features/splash/splash.dart';
import 'package:zoncan/features/wizard/wizard_router.dart';

@Injectable()
class ZRouter {
  // --- Router Properties (Stable Instances) ---
  // These instances must be stable for MaterialApp.router
  // Using late final to ensure they are created once
  // late final QRouteInformationParser routeInformationParser;
  // late final QRouterDelegate routerDelegate;
  late final List<QRoute> routes;
  late final Routing to;

  ZRouter() {
    // --- Route List Definition (Modular) ---
    // This getter builds the final list of routes
    routes = [
      QRoute(
        path: '/',
        builder: () {
          QR.navigator.replaceAll(Routing.to.splash.path);
          return Container(); // Or a loading widget
        },
      ),

      // --- Merging Module Routes ---
      // Assuming each of these returns a QRoute or List<QRoute>
      // If they return List<QRoute>, use the spread operator (...):
      // ...Splash.get.routes,
      // If it's just a single QRoute:
      Splash.get.routes,
      AccountsRouter.get.routes,
      HomeRouetr.get.routes,
      WizardRouetr.get.routes,

      // Not Found route defined in the list as well
      // (Having it both in the list and QR.settings.notFoundPage is good practice)
      QRoute(
        path: '/404', // Specific path for not found
        name: Routing.to.notFound.named,
        builder: () => const NotFoundPage(), // Your 404 page
      ),
    ];
    to = Routing.to;
  }
  // --- Static method for initial setup (run once) ---
  static bool _isInitialized =
      false; // Flag to prevent running setup more than once

  void setupRouter() {
    // If already initialized, do not run again
    if (_isInitialized) return;

    // enable debug logging for all routes
    QR.settings.enableDebugLog = true;

    // enable auto restoration for all routes
    QR.settings.autoRestoration = true;

    //you can set your own logger
    QR.settings.logger = (String message) {
      ZLogger(logLevel: LogLevel.INFO, message: message);
    };

    // Set up the not found route in your app.
    // this route (path and view) will be used when the user navigates to a
    // route that does not exist.
    QR.settings.notFoundPage = QRoute(
      path: 'not-found',
      builder: () => const NotFoundPage(),
    );

    // add observers to the app
    // this observer will be called when the user navigates to new route
    QR.observer.onNavigate.add((path, route) async {
      ZLogger(
        logLevel: LogLevel.INFO,
        message: 'Observer: Navigating to $path',
      );
    });

    // this observer will be called when the popped out from a route
    QR.observer.onPop.add((path, route) async {
      ZLogger(
        logLevel: LogLevel.INFO,
        message: 'Observer: popping out from $path',
      );
    });

    // create initial route that will be used when the app is started
    // or when route is waiting for response
    //QR.settings.iniPage = InitPage();

    // Change the page transition for all routes in your app.
    QR.settings.pagesType = QCustomPage(
      opaque: true,
      withType: QSlidePage(transitionDuration: Duration(microseconds: 500)),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Slide in from the right
        const begin = Offset(
          1.0,
          0.0,
        ); // 1.0 on X means one full width to the right
        const end = Offset.zero; // Offset.zero is (0.0, 0.0), no translation
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(
          tween,
        ); // Apply the tween to the animation

        //return SlideTransition(position: offsetAnimation, child: child);
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
    // 1. Define the Not Found Page in QR settings
    //    Ensure Routing.to.notFound and NotFoundPage are accessible
    QR.settings.notFoundPage = QRoute(
      path: '/404', // Path must match the 404 route in the _router list
      name: Routing.to.notFound.named,
      builder: () => const NotFoundPage(), // Your 404 page widget
    );

    // 2. (Optional) Add global Middlewares if needed
    // QR.settings.globalMiddleware.add(SomeGlobalMiddleware());

    // Set the flag to true so it doesn't run again
    _isInitialized = true;
  }
}
