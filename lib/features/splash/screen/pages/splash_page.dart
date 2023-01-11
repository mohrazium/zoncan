part of zoncan.features.splash;

class SplashPage extends StatelessWidget {
  final int? milliseconds;
  const SplashPage(this.milliseconds, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SplashScreen.show(
      navigationCallback: () {
        Modular.to.navigate(Routing.to.home.path);
      },
      milliseconds: milliseconds,
      title: Text(t.appName),
      loadingText: Text(t.loadingPleaseWait),
    ));
  }
}
