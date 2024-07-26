part of 'router.dart';

class AppRoute {
  final ValueKey key;
  final String title;
  final String named;
  final String path;
  final dynamic args;
  const AppRoute(
    this.path, {
    required this.key,
    required this.title,
    required this.named,
    this.args,
  });
}

class Routing {
  Routing();
  static Routing to = Routing();
  AppRoute get notFound => const AppRoute(
        "/not-found",
        key: ValueKey("not-found-key"),
        title: "404",
        named: "/not-found-page",
      );
  AppRoute get root => const AppRoute(
        "/",
        key: ValueKey("root-key"),
        title: "/",
        named: "/",
      );
  AppRoute get splash => const AppRoute(
        "/splash",
        key: ValueKey("splash-key"),
        title: "splash",
        named: "/splash",
      );
//! Accounts Routes
  AppRoute get accounts => const AppRoute(
        "/accounts",
        key: ValueKey("accounts-key"),
        title: "Accounts",
        named: "/accounts",
      );
  AppRoute get login => AppRoute(
        "${accounts.named}/login",
        key: const ValueKey("login-key"),
        title: "Login",
        named: "/login",
      );
  AppRoute get signup => AppRoute(
        "${accounts.named}/signup",
        key: const ValueKey("signup-key"),
        title: "Sign up",
        named: "/signup",
      );
  AppRoute get passwordReset => AppRoute(
        "${accounts.named}/password-reset",
        key: const ValueKey("password-reset-key"),
        title: "Password Reset",
        named: "/password-reset",
      );
//! Home Routes
  AppRoute get home => const AppRoute(
        "/home",
        key: ValueKey("home-key"),
        title: "Home",
        named: "/home",
      );
  AppRoute get firstSetup => AppRoute(
        "${home.named}/first-setup",
        key: const ValueKey("first-setup-key"),
        title: "First setup",
        named: "/first-setup",
      );
  AppRoute get dashboard => AppRoute(
        "${home.named}/dashboard",
        key: const ValueKey("dashboard-key"),
        title: "Dashboard",
        named: "/dashboard",
      );
}
