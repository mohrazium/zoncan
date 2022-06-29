enum Routes {
  notFound("not-found-page", "/not-found/"),
  root("root-path", "/"),
  splash("splash-page", "/splash/"),
  login("login-module", "/login/"),
  home("home-module", "/home/"),
  ;

  final String name;
  final String path;
  const Routes(this.name, this.path);
}
