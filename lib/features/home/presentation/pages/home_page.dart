
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/src/injection/service_locator.dart';
import 'package:zoncan/config/src/localization/localization.dart';
import 'package:zoncan/config/src/router/routes.dart';
import 'package:zoncan/core/common/components/widgets/toolbar_icon_button.dart';
import 'package:zoncan/features/home/presentation/controllers/home_controller.dart';
import 'package:zoncan/features/home/presentation/views/home_view_large.dart';

class HomePage extends HookWidget {
  final Widget child; // محتوای داخلی (داشبورد، محصولات و ...)

  const HomePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // دریافت کنترلر (اگر همچنان از آن استفاده می‌کنید)
    // useMemoized باعث می‌شود فقط یک بار ساخته شود
    final controller = useMemoized(() => Injection.serviceLocator<HomeController>());

    // معادل initState و didChangeDependencies
    useEffect(() {
      controller.initState();
      // اگر controller نیاز به context دارد، شاید بهتر باشد
      // controller.didChangeDependencies(context); را اینجا فراخوانی کنید
      // یا منطق آن را به داخل build منتقل کنید اگر به context وابسته است

      // معادل dispose
      return () => controller.dispose();
    }, [controller]); // هر بار controller تغییر کند (که اینجا نمی‌کند) اجرا می‌شود

    // UI صفحه Home
    final translator = TranslationsProvider.translator; // فرض وجود این کلاس

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
           toolbarHeight: 40, // ارتفاع سفارشی AppBar
           title: Row(
            children: <Widget>[
              // ویجت‌های AppBar شما... مثل قبل
              // مثال: دکمه خروج
              ToolbarIconButton(
                onTap: () async {
                  await controller.logoutUser();
                  // بعد از خروج به صفحه لاگین هدایت شود
                  // replaceAll برای پاک کردن تاریخچه صفحات داخلی home
                  QR.navigator.replaceAll(Routing.to.login.path);
                },
                icon: const Icon(Icons.logout, color: Colors.deepPurpleAccent),
              ),
              // ... بقیه ویجت‌های AppBar
              Expanded(child: Container()), // فضای خالی
               Observer( // اگر از MobX استفاده می‌کنید
                 builder: (_) => Text(
                   translator.welcome(fullName: controller.currentUserNickName),
                   style: const TextStyle(color: Colors.blueGrey),
                 ),
               ),
               // ... بقیه ویجت‌ها
            ],
          ),
           // ... تنظیمات دیگر AppBar
           backgroundColor: Colors.white, // یا رنگ دلخواه شما
           elevation: 1.0, // سایه کم
           iconTheme: const IconThemeData(color: Colors.blueGrey),
        ),
        // بدنه اصلی که پوسته بیرونی است
        // HomeViewLarge شما می‌تواند اینجا باشد یا مستقیم همینجا پیاده‌سازی شود
        body: HomeViewLarge(
           // این child همان ویجتی است که از QRoute فرزند می‌آید (مثل DashboardPage)
           child: child,
        ),
        // می‌توانید Drawer یا BottomNavigationBar هم اینجا اضافه کنید
        // drawer: AppDrawer(),
      ),
    );
  }
}
