part of '../presentation.dart';

// مثال برای صفحات داخلی Home (اینها هم می‌توانند HookWidget باشند)
class DashboardPage extends Hooks.HookWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Dashboard Content"));
  }
}