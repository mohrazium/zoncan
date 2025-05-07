import 'package:flutter/widgets.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class NavigatorHelper extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    ZLogger(
      logLevel: LogLevel.INFO,
      message: "Route did pushed to ${route.currentResult}",
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    ZLogger(
      logLevel: LogLevel.INFO,
      message: "Route did popped to ${route.currentResult}",
    );
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
