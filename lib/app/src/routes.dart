import 'package:flutter/material.dart';

enum Routes {
  notFound(ValueKey("not-found-key"), "not-found-page", "/not-found/"),
  root(ValueKey("root-key"), "root-path", "/"),
  splash(ValueKey("splash-key"), "splash-page", "/splash/"),
  login(ValueKey("login-key"), "login-module", "/login/"),
  home(ValueKey("home-key"), "home-module", "/home/"),
  ;

  final ValueKey key;
  final String name;
  final String path;

  const Routes(
    this.key,
    this.name,
    this.path,
  );
}
