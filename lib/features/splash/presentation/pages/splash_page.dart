part of '../../splash.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((s) {
      QR.navigator.replaceAll(Routing.to.login.path);
      // App.get.navigationShell.goBranch(2,
      //     initialLocation: 0 == App.get.navigationShell.currentIndex);
    });

    return const SafeArea(
      child: SplashView(),
    );

    // return HomeView();
  }
}
