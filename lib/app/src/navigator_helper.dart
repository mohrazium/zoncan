part of zoncan.app;

class NavigatorHelper {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static String getFirstRouteHistory() {
    List<ParallelRoute> history = Modular.to.navigateHistory;
    return history.first.name;
  }

  static String currentRoute() {
    String route = "";
    try {
      List<ParallelRoute> history = Modular.to.navigateHistory;
      route = history.first.uri.path;
    } catch (ignore) {
      //ignore
    }

    return route;
  }
}
