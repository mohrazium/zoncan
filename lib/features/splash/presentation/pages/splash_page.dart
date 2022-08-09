part of zoncan.features.splash;

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SplashView(),
    );

    // return HomeView();
  }
}
