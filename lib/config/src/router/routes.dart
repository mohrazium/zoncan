import 'package:flutter/foundation.dart';

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

// کلاس اصلی برای دسترسی به مسیرها
// نکته: نام‌ها (named) باید منحصر به فرد باشند در کل برنامه اگر از QR.toName استفاده می‌کنید.
// اگر فقط از QR.to(path) استفاده می‌کنید، تداخل نام مشکلی ندارد.
class Routing {
  Routing._(); // سازنده خصوصی برای جلوگیری از ساخت نمونه مستقیم
  static Routing get to => _instance;
  static final Routing _instance = Routing._();

  // --- مسیرهای عمومی ---
  final AppRoute splash = const AppRoute(
    "/splash",
    key: ValueKey("splash-key"),
    title: "Splash",
    named: "splash", // نام کوتاه و منحصر به فرد
  );

  // --- مسیرهای مربوط به احراز هویت (Accounts) ---
  // این یک مسیر "پدر" یا "گروه" است
  final AppRoute accounts = const AppRoute(
    "/accounts",
    key: ValueKey("accounts-key"),
    title: "Accounts",
    named: "accounts",
  );

  // فرزندان Accounts
  // مسیر کامل با پدر ساخته می‌شود، اما نام می‌تواند کوتاه باشد
  late final AppRoute login = AppRoute(
    "${accounts.path}/login", // مسیر کامل
    key: const ValueKey("login-key"),
    title: "Login",
    named: "login", // نام منحصر به فرد
  );

  late final AppRoute signup = AppRoute(
    "${accounts.path}/signup",
    key: const ValueKey("signup-key"),
    title: "Sign up",
    named: "signup",
  );

  late final AppRoute passwordReset = AppRoute(
    "${accounts.path}/password-reset",
    key: const ValueKey("password-reset-key"),
    title: "Password Reset",
    named: "password_reset",
  );

  // --- مسیرهای مربوط به خانه (Home) ---
  final AppRoute home = const AppRoute(
    "/home",
    key: ValueKey("home-key"),
    title: "Home",
    named: "home",
  );

  // فرزندان Home
  late final AppRoute dashboard = AppRoute(
    "${home.path}/dashboard",
    key: const ValueKey("dashboard-key"),
    title: "Dashboard",
    named: "dashboard",
  );

  late final AppRoute firstSetup = AppRoute(
    "${home.path}/first-setup",
    key: const ValueKey("first-setup-key"),
    title: "First setup",
    named: "first-setup",
  );

  // --- مسیرهای مربوط به خانه (Home) ---
  final AppRoute wizard = const AppRoute(
    "/wizard",
    key: ValueKey("wizard-key"),
    title: "Wizard",
    named: "wizard",
  );
  late final AppRoute wizardStepVerifyPhonenumber = AppRoute(
    "${wizard.path}/step-verfiy-phonenumber",
    key: const ValueKey("step-verfiy-phonenumber"),
    title: "Verfiy Phonenumber",
    named: "step-verfiy-phonenumber",
  );
  late final AppRoute wizardStepPersonalInformation = AppRoute(
    "${wizard.path}/step-personal-information",
    key: const ValueKey("step-personal-information"),
    title: "Personal Information",
    named: "step-personal-information",
  );
  // مسیر Not Found
  final AppRoute notFound = const AppRoute(
    "/not-found",
    key: ValueKey("not-found-key"),
    title: "404",
    named: "not_found",
  );
}
