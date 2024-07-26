part of 'router.dart';

class NavigatorHelper extends NavigatorObserver{
  static GlobalKey<NavigatorState> rootNavigatorKey =
  GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> splashNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> accountsNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> homeNavigatorKey =
  GlobalKey<NavigatorState>();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.info("Route did pushed to ${route.currentResult}");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.info("Route did popped to ${route.currentResult}");
  }

  // static String getFirstRouteHistory() {
  //   List<ParallelRoute> history = Modular.to.navigateHistory;
  //   return history.first.name;
  // }
  //
  // static String currentRoute() {
  //   String route = "";
  //   try {
  //     List<ParallelRoute> history = Modular.to.navigateHistory;
  //     route = history.last.uri.path;
  //   } catch (ignore) {
  //     //ignore
  //   }
  //
  //   return route;
  // }
}
