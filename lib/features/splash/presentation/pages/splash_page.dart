part of '../../splash.dart';

// از HookWidget به جای StatelessWidget استفاده کنید
class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // از useEffect برای اجرای کد فقط یک بار (مشابه initState) استفاده کنید
    // و برای مدیریت side effect ها مثل Future.delayed
    useEffect(() {
      final timer = Future.delayed(const Duration(seconds: 2)); // کمی بیشتر زمان بدهیم
      timer.then((_) {
        // اطمینان حاصل کنید که ویجت هنوز mount شده است
        if (context.mounted) {
          // به مسیر کامل login هدایت کن و تاریخچه را پاک کن
          QR.navigator.replaceAll(Routing.to.login.path);
        }
      });

      // تابع cleanup (مشابه dispose) - اینجا نیازی نیست
      return null;
    }, const []); // آرایه خالی یعنی فقط یک بار اجرا شود

    // UI صفحه Splash شما
    return const SafeArea(
      child: Scaffold( // بهتر است Scaffold داشته باشد
        body: Center(
          child: SplashView(),
        ),
      ),
    );
  }
}
