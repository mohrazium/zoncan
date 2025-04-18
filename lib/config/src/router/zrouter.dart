library;

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/app/context_page.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/core.dart';

import '../../../features/features.dart';

part 'routes.dart';
part 'navigator_helper.dart';

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
          return ContextPage(child: Container()); // Or a loading widget
        },
      ),

      // --- Merging Module Routes ---
      // Assuming each of these returns a QRoute or List<QRoute>
      // If they return List<QRoute>, use the spread operator (...):
      // ...Splash.get.routes,
      // If it's just a single QRoute:
      Splash.get.routes,
      Accounts.get.routes,
      Home.get.routes,

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
      path: 'path',
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
    QR.settings.pagesType = const QFadePage(
      transitionDuration: kAnimationDuration,
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
