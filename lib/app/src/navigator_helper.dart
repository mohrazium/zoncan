import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NavigatorHelper {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static String getFirstRouteHistory() {
    List<ParallelRoute> history = Modular.to.navigateHistory;
    return history.first.name;
  }

  static String currentRoute() {
    List<ParallelRoute> history = Modular.to.navigateHistory;
    return history.last.name;
  }
}
